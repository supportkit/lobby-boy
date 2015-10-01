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

@end
