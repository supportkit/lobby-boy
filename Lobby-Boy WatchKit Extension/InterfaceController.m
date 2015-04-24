//
//  InterfaceController.m
//  Lobby-Boy WatchKit Extension
//
//  Created by Jean-Philippe Joyal on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "InterfaceController.h"
#import "LBProductImageTableRowController.h"
#import "LBProductLabelTableRowController.h"
#import "WKInterfaceImage+ParentLoad.h"



@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self.table setRowTypes:@[@"product-image",@"product-label"]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification{
    NSDictionary * aps = [remoteNotification valueForKey:@"aps"];
    NSDictionary * offer = [aps valueForKey:@"offer"];
    NSString* imageUrl = [offer valueForKey:@"image-url"];
    
    NSString* productName = [offer valueForKey:@"product-name"];
    NSString* productPrice = [offer valueForKey:@"product-price"];
    
    LBProductImageTableRowController *row1 = [self.table rowControllerAtIndex:0];
    [row1.image loadImageWithURLString:imageUrl placeholder:nil];
    
    LBProductLabelTableRowController *row2 = [self.table rowControllerAtIndex:1];
    
    [row2.label setText:productName];
    
    [row2.price setText:[NSString stringWithFormat:@"$%@",productPrice]];
}

- (IBAction)buyButtonAction {
    NSLog(@"Pressed the buy button");
}

@end



