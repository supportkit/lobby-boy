//
//  AppDelegate.h
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kStripePublishableKey;
extern NSString * const kSupportKitAppToken;
extern NSString * const kSetupCompleteKey;
extern NSString * const kPaymentServerBaseUrl;
extern NSString * const kCustomerTokenKey;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

-(void)showDefaultRoot;
@end

