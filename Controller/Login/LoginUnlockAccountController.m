//
//  LoginUnlockAccountController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginUnlockAccountController.h"

@interface LoginUnlockAccountController ()

@end

@implementation LoginUnlockAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    t_count = 0;
    
    [self.navigationItem setHidesBackButton:YES];
    
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backButton;

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
    [confirmNumberTimer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)getConfirmNumberAction:(id)sender {
    if(![confirmNumberTimer isValid]){
        if([_phoneNumberTextField.text isEqualToString:@""] || [_phoneNumberTextField.text length] < 10 || [_phoneNumberTextField.text length] > 13){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:@"휴대번호를 다시 확인해주세요."                                                           delegate:self                                                  cancelButtonTitle:@"확인"                                                  otherButtonTitles:nil, nil];
            [alert show];
        }else{
            t_count = 0;
            confirmNumberTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTimer:) userInfo:nil repeats:YES];
        }
    }
}

- (IBAction)confirmButtonAction:(id)sender {
    //TODO 인증번호 check
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:_idText forKey:@"id"];
    [param setValue:_phoneNumberTextField.text forKey:@"phone_num"];
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyLoginApiService:UnlockMember authKey:nil parameters:param success:^(NSDictionary *data){
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"계정 잠금상태가 해제되었습니다. 아이디와 비밀번호를 다시 입력해 주세요."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert setTag:0];
                [alert show];
            });

        }else if([code isEqual:@"-6"]){
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch(alertView.tag) {
        case 0 : {
            if(buttonIndex == 0){ //"확인" pressed
                [confirmNumberTimer invalidate];
                [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
            }
            break;
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

        [confirmNumberTimer invalidate];
    }
    
}
@end
