//
//  LBStripeCharger.m
//  Lobby-Boy
//
//  Created by Jean-Philippe Joyal on 2015-04-24.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "LBStripeCharger.h"

NSString * const kPaymentServerBaseUrl = @"https://supportkit-staging.herokuapp.com";
NSString * const kStripePublishableKey = @"pk_test_hYK9Bt5xc56yA9nX36mCBBSP";
NSString * const kSupportKitAppToken = @"5wyi84fxf0h9sz487t079z9zq";
NSString * const kSetupCompleteKey = @"setupComplete";
NSString * const kCustomerTokenKey = @"kCustomerTokenKey";

@implementation LBStripeCharger

+(void)change:(NSNumber*)price withCompletionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler{
    NSNumber* priceInCents = @([price intValue] * 100.0);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/charge", kPaymentServerBaseUrl]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"customerId=%@&amount=%ld", [[NSUserDefaults standardUserDefaults] objectForKey:kCustomerTokenKey], [priceInCents longValue]];
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               
                               if (error) {
                                   NSLog(@"%@", [error description]);
                               }
                               handler(response,data,error);
                           }];
}

@end
