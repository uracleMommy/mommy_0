//
//  LoginNewPasswordCreate.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginNewPasswordCreate : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidationLabel;

- (IBAction)savePasswordButtonAction:(id)sender;
@end
