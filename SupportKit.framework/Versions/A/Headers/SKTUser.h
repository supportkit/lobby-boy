//
//  SKTUser.h
//  SupportKit
//
//  Copyright (c) 2015 Radialpoint. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  A callback to be run with the response from sending the stripeToken to SupportKit server
 *
 *  @param error The error returned from the response, or nil in one occurs.
 */
typedef void (^SKTStripeTokenUploadCompletionBlock)(NSError *error);
typedef void (^SKTBuyCompletionBlock)(NSError *error);

@interface SKTUser : NSObject

/**
 *  @abstract Returns the object representing the current user.
 */
+(instancetype)currentUser;

/**
 *  @abstract Adds custom properties to the user. This info is used to provide more context around who a user is.
 *
 *  @discussion Keys must be of type NSString, and values must be of type NSString, NSNumber, or NSDate; any other type will be converted to NSString using the -description method.
 *  
 *  Example:
 *
 *  `[user addProperties:@{ @"nickname" : @"Lil' Big Daddy Slim",  @"weight" : @650, @"premiumUser" : @YES }];`
 *
 *  Changes to user properties are uploaded in batches every 60 seconds, or when the app is sent to the background.
 *
 *  This API is additive, and subsequent calls will override values for the provided keys.
 *
 *  @param properties The properties to set for the current user.
 */
-(void)addProperties:(NSDictionary*)properties;

/**
 *  @abstract The user's first name, to be used as part of the display name when sending messages.
 */
@property(copy) NSString* firstName;

/**
 *  @abstract The user's last name, to be used as part of the display name when sending messages.
 */
@property(copy) NSString* lastName;

/**
 *  @abstract The user's email, to be used to display a gravatar.
 */
@property(copy) NSString* email;

/**
 *  @abstract The date the user started using your service. This can be used to create Whispers for user onboarding.
 */
@property(copy) NSDate* signedUpAt;

/**
 *  @abstract send the token returned return by Stripe after calling `createTokenWithCard:` see https://stripe.com/docs/mobile/ios#stpcard-token
 */
-(void)setStripeToken:(NSString*)token completion:(SKTStripeTokenUploadCompletionBlock)completion;

/**
 *  @abstract if SupportKit has billing info for this user
 */
-(BOOL)hasBillingInfo;

-(void)buy:(NSString*)sku completion:(SKTBuyCompletionBlock)completion;

@end
