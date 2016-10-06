//
//  LoginNewPasswordCreate.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface LoginNewPasswordCreate : CommonViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidationLabel;
@property (strong, nonatomic) NSString *idText;
@property (strong, nonatomic) NSString *phoneNumberText;
@property (strong, nonatomic) NSMutableArray *passwordValidationArr;

- (IBAction)savePasswordButtonAction:(id)sender;
@end
