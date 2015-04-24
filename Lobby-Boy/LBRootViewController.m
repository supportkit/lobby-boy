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
#import "LBStripeCharger.h"

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
    [MBProgressHUD showHUDAddedTo:self.presentedViewController.view animated:YES];
    
    [LBStripeCharger change:@(buyInfo.price) withCompletionHandler:^(NSURLResponse *response,
                                                                    NSData *data,
                                                                    NSError *error) {
        [MBProgressHUD hideHUDForView:self.presentedViewController.view animated:YES];
        
        if (error) {
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
