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
#import "LBStripeCharger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
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
                                                                                                  body:@"Lobby Boy grants your wishes over beautifully simple messaging."
                                                                                                 image:[UIImage imageNamed:@"lobby-logo-1"] buttonText:nil action:nil];
        firstPage.topPadding = 100;
        firstPage.underIconPadding = 195;
        OnboardingContentViewController* secondPage = [OnboardingContentViewController contentWithTitle:@"How does it work?"
                                                                                                   body:@"Ask Lobby Boy anything you need, product or service. He'll handle it."
                                                                                                  image:[UIImage imageNamed:@"lobby-boy"] buttonText:nil action:nil];
        secondPage.topPadding = 30;
        secondPage.underIconPadding = 30;
        
        OnboardingContentViewController* thirdPage = [OnboardingContentViewController contentWithTitle:@"Introduce Yourself"
                                                                                                  body:@"Tell us who you are and preload your credit card for fast checkout."
                                                                                                 image:[UIImage imageNamed:@"register"] buttonText:@"Get Started" action:^{
                                                                                                     [self showUserInfo];
                                                                                                 }];
        thirdPage.topPadding = 0;
        thirdPage.underIconPadding = 0;
        thirdPage.iconWidth = self.window.bounds.size.width;
        thirdPage.buttonFontSize = 18;
        
        OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:nil contents:@[firstPage, secondPage, thirdPage]];
        onboardingVC.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        onboardingVC.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
        onboardingVC.underTitlePadding = 10;
        onboardingVC.bottomPadding = 50;
        onboardingVC.titleFontSize = 25;
        onboardingVC.bodyFontSize = 18;
        onboardingVC.buttonTextColor = skSettings.conversationAccentColor;
        onboardingVC.titleTextColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
        onboardingVC.bodyTextColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
        
        onboardingVC.shouldFadeTransitions = YES;
        self.window.rootViewController = onboardingVC;
    } else {
        self.window.rootViewController = [[LBRootViewController alloc] initWithNibName:@"LBRootViewController" bundle:nil];
    }

    [self.window makeKeyAndVisible];
    
    
    UIMutableUserNotificationAction *notificationAction1 = [[UIMutableUserNotificationAction alloc] init];
    notificationAction1.identifier = @"firstButtonAction";
    notificationAction1.title = @"Show me";
    notificationAction1.activationMode = UIUserNotificationActivationModeForeground;
    notificationAction1.authenticationRequired = NO;

    
    UIMutableUserNotificationCategory *notificationCategory = [[UIMutableUserNotificationCategory alloc] init];
    notificationCategory.identifier = @"myCategory";
    [notificationCategory setActions:@[notificationAction1] forContext:UIUserNotificationActionContextDefault];
    [notificationCategory setActions:@[notificationAction1] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:notificationCategory, nil];
    
    UIUserNotificationType notificationType = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificationType categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    
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
    }else if ([value isEqualToString:@"buy"]){
        NSNumber *price = userInfo[@"price"];
        NSLog(@"chaging from watch");
        [LBStripeCharger change:price withCompletionHandler:^(NSURLResponse *response,
                                                             NSData *data,
                                                             NSError *error) {
            
            if (error) {
                NSLog(@"Failled to charge from the watch");
                reply(@{@"message":@"error"});
            } else {
                NSLog(@"Charged from the watch");
                reply(@{@"message":@"success"});
            }
        }];
    }
}

@end
