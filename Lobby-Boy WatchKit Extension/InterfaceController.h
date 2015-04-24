//
//  InterfaceController.h
//  Lobby-Boy WatchKit Extension
//
//  Created by Jean-Philippe Joyal on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;

- (IBAction)buyButtonAction;

@property (weak, nonatomic) IBOutlet WKInterfaceButton* buyButton;

@property NSNumber* currentItemPrice;

@end
