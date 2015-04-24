//
//  LBStripeCharger.h
//  Lobby-Boy
//
//  Created by Jean-Philippe Joyal on 2015-04-24.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBStripeCharger : NSObject

+(void)change:(NSNumber*)price withCompletionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler;

@end
