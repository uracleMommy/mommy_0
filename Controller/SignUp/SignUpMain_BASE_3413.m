//
//  SignUpMain.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMain.h"

@interface SignUpMain ()

@end

@implementation SignUpMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView.contentSize = CGSizeMake(320, 1000);
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

#pragma mark UIPickerView Delegate

#pragma UITextField Delegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    NSLog(@"PSH textFieldShouldEndEditing");
//    NSLog(@"%@", textField.);
    if(textField == _idTextField){
        NSLog(@"id");
        NSString *idText = [[NSString alloc] initWithString:_idTextField.text];
        if([idText isEqualToString:@""]){
            _idValidationLabel.textColor = [UIColor lightGrayColor];
            return YES;
        }
        
        NSRange match = [idText rangeOfString:@"([A-z]+[0-9]+)" options:  NSRegularExpressionSearch];
        
        if(match.location != NSNotFound){
            NSLog(@"영문 숫자 구성");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 9)];
            [_idValidationLabel setAttributedText: text];
        }else{
            NSLog(@"2번째 빨강");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(0, 9)];
            [_idValidationLabel setAttributedText: text];
        }
        
        if([idText length] > 4 && [idText length] < 13){
            NSLog(@"5~12자 이내");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(10, 10)];
            [_idValidationLabel setAttributedText: text];
        }else{
            NSLog(@"2번째 빨강");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _idValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(10, 10)];
            [_idValidationLabel setAttributedText: text];
        }
        
        
        
        
        //영문, 숫자구성
        //5~12자 이내
        //중복되지않음
    }else if(textField == _passwordTextField){
        NSLog(@"password");
        NSString *passwordText = [[NSString alloc] initWithString:_passwordTextField.text];
        if([passwordText isEqualToString:@""]){
            _passwordValidationLabel.textColor = [UIColor lightGrayColor];
            return YES;
        }
        
        if([passwordText length] > 5 && [passwordText length] < 19){
            NSLog(@"6~18자 이내");
            
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 10)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            NSLog(@"1번째 빨강");
            
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(0, 10)];
            [_passwordValidationLabel setAttributedText: text];
        }
        
        NSRange match = [passwordText rangeOfString:@"([A-z]+[0-9]+[?`_=~!@#$%^&*()+-]+)" options:  NSRegularExpressionSearch];
        
            if(match.location != NSNotFound){
            NSLog(@"영문 숫자 특수문자 구성");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(11, 15)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            NSLog(@"2번째 빨강");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(11, 15)];
            [_passwordValidationLabel setAttributedText: text];
        }
        
        //6~18자 이내
        //영문, 숫자, 특수문자 조합
        
        
    }else if(textField == _confirmPasswordTextField){
        NSLog(@"confirm password");
        NSString *confirmPasswordText = [[NSString alloc] initWithString:_confirmPasswordTextField.text];
        
        if([confirmPasswordText isEqualToString: @""]){
            //빈값
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor lightGrayColor]
                         range:NSMakeRange(16, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }else if([_passwordTextField.text isEqualToString:confirmPasswordText]){
            //일치
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }else{
            //불일치
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _passwordValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(28, 7)];
            [_passwordValidationLabel setAttributedText: text];
        }
        
        //비밀번호 일치
    }
    return YES;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"PSH textFieldDidEndEditing");
//}


@end
