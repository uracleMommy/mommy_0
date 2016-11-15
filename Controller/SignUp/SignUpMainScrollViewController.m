//
//  SignUpMainScrollViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMainScrollViewController.h"

@interface SignUpMainScrollViewController ()

@end

@implementation SignUpMainScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_birthdayTextField setDropDownMode : IQDropDownModeDatePicker];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    [_birthdayTextField setDateFormatter:formatter];
    [_birthdayTextField setDate:[formatter dateFromString:@"1980.01.01"]];
    [_birthdayTextField setMaximumDate:[NSDate date]];
    
    _idValidationArr = [[NSMutableArray alloc] initWithArray:@[@"N", @"N", @"N"]];
    _passwordValidationArr = [[NSMutableArray alloc] initWithArray:@[@"N", @"N", @"N"]];
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

- (IBAction)getConfirmNumberAction:(id)sender {
    if(![_confirmNumberTimer isValid]){
        if([_phoneNumberTextField.text isEqualToString:@""] || [_phoneNumberTextField.text length] < 10 || [_phoneNumberTextField.text length] > 13){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:@"휴대번호를 확인해주세요."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil, nil];
            [alert show];

        }else{
            t_count = 0;
            _confirmNumberTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTimer:) userInfo:nil repeats:YES];
        }
    }
}

- (void)countTimer:(NSTimer *)timer{
    t_count++;
    
    int timerText = 180-t_count;
    _timerLabel.text = [NSString stringWithFormat:@"%02d : %02d", timerText/60, timerText%60];
    
    if(t_count == 180){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"인증번호 입력 제한시간을 초과하였습니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];

        [_confirmNumberTimer invalidate];
    }
    
}

#pragma UITextField Delegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
        NSLog(@"PSH textFieldShouldEndEditing");
    if(textField == _idTextField){  //id TextField end editing
        NSString *idText = [[NSString alloc] initWithString:_idTextField.text];
        
        if([idText isEqualToString:@""]){   //empty value
            [_idValidationArr replaceObjectAtIndex:0 withObject:@"N"];
            [_idValidationArr replaceObjectAtIndex:1 withObject:@"N"];
            [_idValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            _idValidationLabel.textColor = [UIColor lightGrayColor];
            return YES;
        }
        
        
        if([idText rangeOfString:@"([A-z]+)" options:  NSRegularExpressionSearch].location != NSNotFound && [idText rangeOfString:@"([0-9]+)" options:  NSRegularExpressionSearch].location != NSNotFound){        //english & number Used Validation OK
            
            [_idValidationArr replaceObjectAtIndex:0 withObject:@"Y"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 9)];
            [_idValidationLabel setAttributedText: text];
        }else{
            [_idValidationArr replaceObjectAtIndex:0 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(0, 9)];
            [_idValidationLabel setAttributedText: text];
        }
        
        if([idText length] > 4 && [idText length] < 13){    //id length Validation OK
            [_idValidationArr replaceObjectAtIndex:1 withObject:@"Y"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(10, 10)];
            [_idValidationLabel setAttributedText: text];
        }else{
            [_idValidationArr replaceObjectAtIndex:1 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(10, 10)];
            [_idValidationLabel setAttributedText: text];
        }
        
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:[_idTextField text] forKey:@"id"];
        
        [[MommyRequest sharedInstance] mommySignInApiService:IdDuplicateCheck authKey:nil parameters:param success:^(NSDictionary *data){
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){    //id Duplicate OK
                [_idValidationArr replaceObjectAtIndex:2 withObject:@"Y"];
                dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *text =
                        [[NSMutableAttributedString alloc]
                         initWithAttributedString: _idValidationLabel.attributedText];
                        
                        [text addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor blackColor]
                                     range:NSMakeRange(21, 8)];
                        [_idValidationLabel setAttributedText: text];
                    });
            }else{
                [_idValidationArr replaceObjectAtIndex:2 withObject:@"N"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableAttributedString *text =
                    [[NSMutableAttributedString alloc]
                     initWithAttributedString: _idValidationLabel.attributedText];
                    
                    [text addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor redColor]
                                 range:NSMakeRange(21, 8)];
                    [_idValidationLabel setAttributedText: text];
                });
                
            }
        } error:^(NSError *error) {
            [_idValidationArr replaceObjectAtIndex:2 withObject:@"N"];
            NSLog(@"PSH error %@", error);
        } ];
        
    }else if(textField == _passwordTextField){  //password TextField end editing
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
    }else if(textField == _confirmPasswordTextField){        //confirmPassWord TextField End Editing
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
