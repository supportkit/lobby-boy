//
//  LBUserInfoViewController.h
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PaymentKit/PTKView.h>

@interface LBUserInfoViewController : UIViewController

@property(nonatomic, strong) PTKView* paymentView;

@property(nonatomic, strong) IBOutlet UIView* paymentViewContainer;
@property(nonatomic, strong) IBOutlet UITextField* firstNameField;
@property(nonatomic, strong) IBOutlet UITextField* lastNameField;
@property(nonatomic, strong) IBOutlet UITextField* emailField;

@property(nonatomic, strong) IBOutlet UILabel* ccInfoLabel;
@property(nonatomic, strong) IBOutlet UIButton* saveButton;

-(IBAction)buttonTapped:(id)sender;
-(IBAction)propertyFieldChanged:(id)sender;
@end
