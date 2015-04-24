//
//  LBRootViewController.h
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SupportKit/SupportKit.h>

@interface LBRootViewController : UIViewController < SKTConversationDelegate >

@property(nonatomic, strong) IBOutlet UIButton* talkButton;

-(IBAction)talkAction:(id)sender;

@end
