//
//  LBRootViewController.m
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "LBRootViewController.h"
#import <SupportKit/SupportKit.h>
#import "AppDelegate.h"
#import "MBProgressHud.h"

@implementation LBRootViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SupportKit conversation].delegate = self;
}

-(IBAction)talkAction:(id)sender
{
    [SupportKit showConversation];
}

-(void)conversation:(SKTConversation *)conversation didSelectBuyWithInfo:(SKTMessageBuyInfo*)buyInfo completion:(void (^)(BOOL))completion {
    
    NSNumber* price = @(buyInfo.price * 100.0);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/charge", kPaymentServerBaseUrl]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"customerId=%@&amount=%ld", [[NSUserDefaults standardUserDefaults] objectForKey:kCustomerTokenKey], [price longValue]];
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.presentedViewController.view animated:YES];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               [MBProgressHUD hideHUDForView:self.presentedViewController.view animated:YES];
                               
                               if (error) {
                                   NSLog(@"%@", [error description]);
                                   [[[UIAlertView alloc] initWithTitle:@"Purchase Failed" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                               } else {
                                   [SupportKit track:@"Purchase"];
                                   
                                   [conversation sendMessage:[[SKTMessage alloc] initWithText:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]]];
                               }
                               completion(error == nil);
                           }];
}

-(void)conversation:(SKTConversation *)conversation didSelectMoreInfo:(SKTMessageBuyInfo*)buyInfo {
    NSURL *url = [NSURL URLWithString:buyInfo.moreInfoUrl];
    
   [SupportKit track:@"More Info"];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}

@end
