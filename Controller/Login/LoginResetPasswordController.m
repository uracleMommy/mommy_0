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
        //TODO validation check
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

- (IBAction)confirmButtonAction:(id)sender {
    //TODO 인증번호 체크
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
        [_confirmNumberTimer invalidate];
    }
    
}

@end
