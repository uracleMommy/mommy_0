//
//  MoreMyPagePasswordChangeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPagePasswordChangeViewController.h"

@interface MoreMyPagePasswordChangeViewController ()

@end

@implementation MoreMyPagePasswordChangeViewController

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

- (IBAction)saveButtonAction:(id)sender {
    Boolean validationFlag = TRUE;
    
    for( int i=0 ; i<_passwordValidationArr.count ; i++){
        if([[_passwordValidationArr objectAtIndex:i] isEqualToString:@"N"]){
            validationFlag = FALSE;
            break;
        }
    }
    
    if([[_passwordValidationArr objectAtIndex:0] isEqualToString:@"N"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"변경할 비밀번호가 일치하지 않습니다.\n확인 후 다시 입력해 주세요."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else if(!validationFlag || [_beforePasswordTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"입력된 정보를 확인하시기 바랍니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        
        [param setObject:_beforePasswordTextField.text forKey:@"password"];
        [param setObject:_passwordTextField.text forKey:@"new_password"];
        
        [[MommyRequest sharedInstance] mommyMyPageApiService:MyPageUpdatePassword authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"비밀번호가 재설정 되었습니다.\n새롭게 생성된 비밀번호로 다시 로그인해주세요."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                alert.tag = 0;
                [alert show];
            }else if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"-21"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"비밀번호 재설정에 실패하였습니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
        } error:^(NSError *error) {
            
        }];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 0){
        if(buttonIndex == 0){ //"확인" pressed
            [self goBack];
        }
    }
}


-(void)goBack{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
@end
