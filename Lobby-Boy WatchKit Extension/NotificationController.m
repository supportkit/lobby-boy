//
//  NotificationController.m
//  Lobby-Boy WatchKit Extension
//
//  Created by Jean-Philippe Joyal on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "NotificationController.h"
#import "WKInterfaceImage+ParentLoad.h"


@interface NotificationController()

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

/*
- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}
*/


//- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
//    // This method is called when a remote notification needs to be presented.
//    // Implement it if you use a dynamic notification interface.
//    // Populate your dynamic notification interface as quickly as possible.
//    //
//    // After populating your dynamic notification interface call the completion block.
//    [_image loadImageWithURLString:@"http://www.raywenderlich.com/wp-content/themes/raywenderlich/images/tutorial-team/57019.jpg" placeholder:nil withCompletion:completionHandler];
//}


@end

