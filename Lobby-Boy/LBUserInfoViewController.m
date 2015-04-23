//
//  LBUserInfoViewController.m
//  Lobby-Boy
//
//  Created by Mike on 2015-04-23.
//  Copyright (c) 2015 SupportKit.io. All rights reserved.
//

#import "LBUserInfoViewController.h"
#import <SupportKit/SupportKit.h>

@interface LBUserInfoViewController ()

@end

@implementation LBUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)buttonTapped:(id)sender {
    if(!self.firstNameField.hidden) {
        [SKTUser currentUser].firstName = self.firstNameField.text;
        [SKTUser currentUser].lastName = self.lastNameField.text;
        [SKTUser currentUser].email = self.emailField.text;
        
        self.firstNameField.hidden = YES;
        self.lastNameField.hidden = YES;
        self.emailField.hidden = YES;
        
        self.paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, self.firstNameField.frame.origin.y, 290, 55)];
        [self.view addSubview:self.paymentView];
    } else {
        
    }
}

@end
