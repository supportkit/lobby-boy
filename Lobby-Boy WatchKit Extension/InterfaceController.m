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
    LBProductImageTableRowController *row1 = [self.table rowControllerAtIndex:0];
    
    LBProductLabelTableRowController *row2 = [self.table rowControllerAtIndex:1];
    
    [row1.image loadImageWithURLString:@"http://imgs.xkcd.com/comics/dress_color.png" placeholder:nil];
    
    [row2.label setText:@"This dress looks awesome"];
    
    
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



