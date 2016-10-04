//
//  LoginResetPasswordController.h
//  co.medisolution
//
//  Created by uracle on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ViewController.h"
#import "notPasteField.h"
#import "CommonViewController.h"
#import "LoginNewPasswordCreate.h"

@interface LoginResetPasswordController : CommonViewController

@property (assign, nonatomic) int t_count;
@property (strong, nonatomic) NSTimer *confirmNumberTimer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet notPasteField *idTextField;
@property (weak, nonatomic) IBOutlet notPasteField *phoneNumberTextField;

- (IBAction)getConfirmNumberAction:(id)sender;
- (IBAction)confirmButtonAction:(id)sender;
@end
