//
//  QuestionScrollViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "QuestionScrollViewController.h"

@interface QuestionScrollViewController ()

@end

@implementation QuestionScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setKeyboardEnabled:NO];
    
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    _etcView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _etcView.layer.borderWidth = 1.0f;
    _etcView.layer.cornerRadius = 10;
    
//    self.view.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:235.0f/255.0f alpha:1.0f];
    
    _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
    _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
    _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
    
    _firstQuestionSelectedNumber = @"1";
    _secondQuestionSelectedNumber = @"1";
    _thirdQuestionSelectedNumber = @"1";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonSelect:(id)sender {
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageFirstQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 1:
            _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion2.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageFirstQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 2:
            _imageFirstQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageFirstQuestion3.image = [UIImage imageNamed:@"radio_btn_on"];
            break;
        default:
            break;
    }
    
    _firstQuestionSelectedNumber = [NSString stringWithFormat:@"%ld", (long)button.tag + 1];
}
- (IBAction)secondButtonSelect:(id)sender {
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageSecondQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 1:
            _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion2.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageSecondQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 2:
            _imageSecondQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageSecondQuestion3.image = [UIImage imageNamed:@"radio_btn_on"];
            break;
        default:
            break;
    }
    
    _secondQuestionSelectedNumber = [NSString stringWithFormat:@"%ld", (long)button.tag + 1];
}
- (IBAction)thirdButtonSelect:(id)sender {
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageThirdQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 1:
            _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion2.image = [UIImage imageNamed:@"radio_btn_on"];
            _imageThirdQuestion3.image = [UIImage imageNamed:@"radio_btn_off"];
            break;
        case 2:
            _imageThirdQuestion1.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion2.image = [UIImage imageNamed:@"radio_btn_off"];
            _imageThirdQuestion3.image = [UIImage imageNamed:@"radio_btn_on"];
            break;
        default:
            break;
    }
    
    _thirdQuestionSelectedNumber = [NSString stringWithFormat:@"%ld", (long)button.tag + 1];
}

#pragma 문진정보 보내기
- (void) questionResultInfoSend {
    
    NSDictionary *parameters;
    
    // 21주차 이상
    if ([_momWeek intValue] >= 21) {
        
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:_momWeek, @"mom_week", _firstQuestionSelectedNumber, @"question1", _secondQuestionSelectedNumber, @"question2", _thirdQuestionSelectedNumber, @"question3", _txtView.text, @"question4", nil];
    }
    // 21주차 미만
    else {
        
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:_momWeek, @"mom_week", _firstQuestionSelectedNumber, @"question1", _secondQuestionSelectedNumber, @"question2", _txtView.text, @"question4", nil];
    }
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    
    [[MommyRequest sharedInstance] mommyDashboardApiService:DashboardQuestionInfoInsert authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data == nil) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirmAlertAction];
                    //[self presentViewController:alert animated:YES completion:nil];
                    [self hideIndicator];
                });
                return;
            }
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    [self hideIndicator];
                });
                return;
            }
            
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

@end













