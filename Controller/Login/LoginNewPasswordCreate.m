//
//  LoginNewPasswordCreate.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginNewPasswordCreate.h"

@interface LoginNewPasswordCreate ()

@end

@implementation LoginNewPasswordCreate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
    
    _passwordValidationArr = [[NSMutableArray alloc] initWithArray:@[@"N", @"N", @"N"]];

    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;
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

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITextField Delegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField == _passwordTextField){    //password textField
        NSString *passwordText = [[NSString alloc] initWithString:_passwordTextField.text];
        
        if([passwordText isEqualToString:@""]){ //empty value
            [_passwordValidationArr replaceObjectAtIndex:0 withObject:@"N"];
            [_passwordValidationArr replaceObjectAtIndex:1 withObject:@"N"];
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            
            _passwordValidationLabel.textColor = [UIColor lightGrayColor];
            return YES;
        }
        
        if([passwordText length] > 5 && [passwordText length] < 19){    //password length validation OK
            [_passwordValidationArr replaceObjectAtIndex:0 withObject:@"Y"];
            
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 10)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            [_passwordValidationArr replaceObjectAtIndex:0 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(0, 10)];
            [_passwordValidationLabel setAttributedText: text];
        }
        
        if([passwordText rangeOfString:@"([A-z]+)" options:  NSRegularExpressionSearch].location != NSNotFound && [passwordText rangeOfString:@"([0-9]+)" options:  NSRegularExpressionSearch].location != NSNotFound && [passwordText rangeOfString:@"([?`_=~!@#$%^&*()+-]+)" options:  NSRegularExpressionSearch].location != NSNotFound){  //english & number & special char Check OK
            [_passwordValidationArr replaceObjectAtIndex:1 withObject:@"Y"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(11, 15)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            [_passwordValidationArr replaceObjectAtIndex:1 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(11, 15)];
            [_passwordValidationLabel setAttributedText: text];
        }
        
        NSString *confirmPasswordText = [[NSString alloc] initWithString:_confirmPasswordTextField.text];
        
        if([confirmPasswordText isEqualToString: @""]){ //empty value
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor lightGrayColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }else if([passwordText isEqualToString:confirmPasswordText]){   //equal OK
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"Y"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }
    }else if(textField == _confirmPasswordTextField){ //confirmPassWord TextField End Editing
        NSString *passwordText = [[NSString alloc] initWithString:_passwordTextField.text];
        NSString *confirmPasswordText = [[NSString alloc] initWithString:_confirmPasswordTextField.text];
        
        if([confirmPasswordText isEqualToString: @""]){ //empty value
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor lightGrayColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }else if([passwordText isEqualToString:confirmPasswordText]){   //equal OK
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"Y"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            [_passwordValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }
    }
    return YES;
}
- (IBAction)savePasswordButtonAction:(id)sender {
    Boolean validationFlag = TRUE;
    
    
    for( int i=0 ; i<_passwordValidationArr.count ; i++){
        if([[_passwordValidationArr objectAtIndex:i] isEqualToString:@"N"]){
            validationFlag = FALSE;
            break;
        }
    }

    if(!validationFlag){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"입력된 정보를 확인하시기 바랍니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        
        [param setValue:_idText forKey:@"id"];
        [param setValue:_phoneNumberText forKey:@"phone_num"];
        [param setValue:_passwordTextField.text forKey:@"password"];
        
        [self showIndicator];
        [[MommyRequest sharedInstance] mommyLoginApiService:SetPassword authKey:nil parameters:param success:^(NSDictionary *data){
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"비밀번호가 재설정 되었습니다.\n새롭게 생성된 비밀번호로 다시 로그인해주세요."
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles:nil, nil];
                    [alert setTag:1];
                    [alert show];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } error:^(NSError *error) {
            NSLog(@"PSH error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } ];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        if(buttonIndex == 0){ //"확인" pressed
            [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
        }
    }
}

@end
