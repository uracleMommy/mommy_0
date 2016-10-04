//
//  SignUpMainScrollViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDownTextField.h"
#import "IQKeyboardManager.h"
#import "CommonViewController.h"

@interface SignUpMainScrollViewController : CommonViewController <UITextFieldDelegate, IQDropDownTextFieldDelegate> {
    int t_count;
    NSTimer *confirmNumberTimer;
}

- (IBAction)getConfirmNumberAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *idValidationLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidationLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *birthdayTextField;

@end
