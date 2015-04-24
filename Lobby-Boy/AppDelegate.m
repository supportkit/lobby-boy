//
//  AppDelegate.m
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "AppDelegate.h"
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"
#import <SupportKit/SupportKit.h>
#import "LBUserInfoViewController.h"
#import "LBRootViewController.h"
#import "Stripe.h"

NSString * const kStripePublishableKey = @"pk_test_XMVpxPrQVvXdN8x98LKZ1m8y";
NSString * const kSupportKitAppToken = @"7l7ldpc0cyir8jgqw7eimped4";
NSString * const kSetupCompleteKey = @"setupComplete";
NSString * const kPaymentServerBaseUrl = @"https://lobbyboy.herokuapp.com";
NSString * const kCustomerTokenKey = @"kCustomerTokenKey";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Stripe setDefaultPublishableKey:kStripePublishableKey];
    
    SKTSettings* skSettings = [SKTSettings settingsWithAppToken:kSupportKitAppToken];
    skSettings.enableAppWideGesture = NO;
    skSettings.enableGestureHintOnFirstLaunch = NO;
    skSettings.conversationAccentColor = [UIColor colorWithRed:145.0/255.0 green:45.0/255.0 blue:141.0/255.0 alpha:1.0];

    [SupportKit initWithSettings:skSettings];
    
    //Show the onboarding controller if setup is not complete
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    if(![def boolForKey:kSetupCompleteKey]) {
        OnboardingContentViewController* firstPage = [OnboardingContentViewController contentWithTitle:@"Nice to meet you!"
                                                                                                  body:@"Get whatever you want, anytime, with no hassle"
                                                                                                 image:[UIImage imageNamed:@"lobbyboy.jpg"] buttonText:nil action:nil];
        OnboardingContentViewController* secondPage = [OnboardingContentViewController contentWithTitle:@"How does it work?"
                                                                                                   body:@"Text Lobby Boy anything you need, he'll handle it."
                                                                                                  image:[UIImage imageNamed:@"lobbyboy.jpg"] buttonText:nil action:nil];
        
        OnboardingContentViewController* thirdPage = [OnboardingContentViewController contentWithTitle:@"Introduce yourself"
                                                                                                   body:@"Tell us who you are and preload your credit card for fast checkout"
                                                                                                  image:[UIImage imageNamed:@"lobbyboy.jpg"] buttonText:@"Get Started" action:^{
                                                                                                      [self showUserInfo];
                                                                                                  }];
        
        OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"salmon.png"] contents:@[firstPage, secondPage, thirdPage]];
        
        onboardingVC.shouldFadeTransitions = YES;
        self.window.rootViewController = onboardingVC;
    } else {
        self.window.rootViewController = [[LBRootViewController alloc] initWithNibName:@"LBRootViewController" bundle:nil];
    }
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)showUserInfo {
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.window.rootViewController = [[LBUserInfoViewController alloc] initWithNibName:@"LBUserInfoViewController" bundle:nil];
    } completion:nil];
}

-(void)showDefaultRoot {
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.window.rootViewController = [[LBRootViewController alloc] initWithNibName:@"LBRootViewController" bundle:nil];
    } completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply {
    NSString *value = userInfo[@"key"];
    if ([value isEqualToString:@"loadImage"]) {
        NSURL *url = [NSURL URLWithString:userInfo[@"urlString"]];
        UIImage *image = nil;
        NSData *data = nil;
        BOOL cached = YES;
        if (!image) {
            cached = NO;
            data = [NSData dataWithContentsOfURL:url];
            image = [UIImage imageWithData:data];
        } else {
            data = UIImageJPEGRepresentation(image, 1);
        }
        if (data) {
            reply(@{@"result":data, @"isFromCache":@(cached)});
        }
    }
}

@end
