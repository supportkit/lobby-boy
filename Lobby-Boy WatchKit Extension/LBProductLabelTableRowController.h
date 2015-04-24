//
//  LBProductLabelTableRowController.h
//  Lobby-Boy
//
//  Created by Jean-Philippe Joyal on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>



@interface LBProductLabelTableRowController : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *price;



@end
