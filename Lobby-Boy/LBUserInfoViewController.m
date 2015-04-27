//
//  LBUserInfoViewController.m
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "LBUserInfoViewController.h"
#import <SupportKit/SupportKit.h>
#import "Stripe.h"
#import "AppDelegate.h"
#import "MBProgressHud.h"

@interface LBUserInfoViewController () < PTKViewDelegate >

@end

@implementation LBUserInfoViewController

-(IBAction)buttonTapped:(id)sender {
    if(!self.firstNameField.hidden) {
        [SKTUser currentUser].firstName = self.firstNameField.text;
        [SKTUser currentUser].lastName = self.lastNameField.text;
        [SKTUser currentUser].email = self.emailField.text;
        
        [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        self.saveButton.enabled = NO;
        
        self.firstNameField.hidden = YES;
        self.lastNameField.hidden = YES;
        self.emailField.hidden = YES;
        self.ccInfoLabel.hidden = NO;
        
        self.paymentView = [[PTKView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-290)/2, self.firstNameField.frame.origin.y, 290, 55)];
        self.paymentView.delegate = self;
        [self.view addSubview:self.paymentView];
    } else {
        //Create the stripe token and save it
        STPCard *card = [[STPCard alloc] init];
        card.number = self.paymentView.card.number;
        card.expMonth = self.paymentView.card.expMonth;
        card.expYear = self.paymentView.card.expYear;
        card.cvc = self.paymentView.card.cvc;
        card.name = [NSString stringWithFormat:@"%@ %@", [SKTUser currentUser].firstName, [SKTUser currentUser].lastName];
        
        [[STPAPIClient sharedClient] createTokenWithCard:card
                                              completion:^(STPToken *token, NSError *error) {
                                                  if (error) {
                                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                      NSLog(@"%@", [error description]);
                                                  } else {
                                                      //Create customer on ed's backend
                                                      //save the customer token in user defaults
                                                      [self createCustomerTokenWithCardToken:token completion:^(NSString *customerToken, NSError *error) {
                                                          if(error) {
                                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                              NSLog(@"%@", [error description]);
                                                          } else {
                                                              NSLog(@"Customer token: %@", customerToken);
                                                              
                                                              [SupportKit track:@"Account Setup Complete"];
                                                              [[NSUserDefaults standardUserDefaults] setObject:customerToken forKey:kCustomerTokenKey];
                                                              [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSetupCompleteKey];
                                                              
                                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                              
                                                              AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                                              [app showDefaultRoot];
                                                          }
                                                      }];
                                                  }
                                              }];
    }
}


-(void)createCustomerTokenWithCardToken:(STPToken*)token completion:(void (^)(NSString* customerToken, NSError* error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user", kPaymentServerBaseUrl]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@&email=%@&name=%@", token.tokenId, [SKTUser currentUser].email, token.card.name];
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               if (error) {
                                   completion(nil, error);
                               } else {
                                   completion([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], nil);
                               }
                           }];
}

-(IBAction)propertyFieldChanged:(id)sender {
    if(self.firstNameField.text.length && self.lastNameField.text.length && self.emailField.text.length) {
        self.saveButton.enabled = YES;
    } else {
        self.saveButton.enabled = NO;
    }
}

- (void) paymentView:(PTKView*)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid {
    if(valid) {
        self.saveButton.enabled = YES;
    }
}
@end
