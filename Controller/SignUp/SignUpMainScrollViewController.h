//
//  SignUpMainScrollViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpMainScrollViewController : UIViewController <UITextFieldDelegate> {
    int t_count;
    NSTimer *confirmNumberTimer;
    UIDatePicker *birthdayPicker;
}

- (IBAction)getConfirmNumberAction:(id)sender;
- (IBAction)moveSignUpMommyInfo:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *idValidationLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidationLabel;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;

@end
