//
//  LoginResetPasswordController.m
//  co.medisolution
//
//  Created by uracle on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginResetPasswordController.h"

@interface LoginResetPasswordController ()

@end

@implementation LoginResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
    
    
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

- (void)goBack {
    [_confirmNumberTimer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getConfirmNumberAction:(id)sender {
    if(![_confirmNumberTimer isValid]){
        if([_idTextField.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:@"아이디를 입력해주시기 바랍니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil, nil];
            [alert show];

        }else if([_phoneNumberTextField.text isEqualToString:@""]){
            if([_phoneNumberTextField.text length] < 10 || [_phoneNumberTextField.text length] > 13){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"핸드폰번호를 확인해주시기 바랍니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert show];

            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"핸드폰번호를 입력해주시기 바랍니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert show];
   
            }
        }else{
            NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            
            [param setValue:_idTextField.text forKey:@"id"];
            [param setValue:_phoneNumberTextField.text forKey:@"phone_num"];
            
            [self showIndicator];
            [[MommyRequest sharedInstance] mommyLoginApiService:ResetPassword authKey:nil parameters:param success:^(NSDictionary *data){
                
                NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
                if([code isEqual:@"0"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _t_count = 0;
                        _confirmNumberTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTimer:) userInfo:nil repeats:YES];
                    });
                }else if([code isEqual:@"-5"]){
                    //등록된 사용자 조회 실패
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                        message:@"등록된 사용자 정보가 없습니다.\n확인 후 다시 입력해 주세요."
                                                                       delegate:self
                                                              cancelButtonTitle:@"취소"
                                                              otherButtonTitles:nil, nil];
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
}

- (IBAction)confirmButtonAction:(id)sender {
    //TODO 인증번호 체크
    [_confirmNumberTimer invalidate];
    [self performSegueWithIdentifier:@"moveCreatePasswordViewSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moveCreatePasswordViewSegue"])
    {
        LoginNewPasswordCreate *vc = [segue destinationViewController];
        [vc setIdText:_idTextField.text];
        [vc setPhoneNumberText:_phoneNumberTextField.text];
    }
}


- (void)countTimer:(NSTimer *)timer{
    _t_count++;
    
    int timerText = 180-_t_count;
    _timerLabel.text = [NSString stringWithFormat:@"%02d : %02d", timerText/60, timerText%60];
    
    if(_t_count == 180){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"인증번호 입력 제한시간을 초과하였습니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];

        [_confirmNumberTimer invalidate];
    }
    
}

@end
