//
//  LoginMain.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginMain.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>
#import <sys/utsname.h>

@interface LoginMain ()

@end

@implementation LoginMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    
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
    
    //id field Setting
    UIImage *idFieldImage = [UIImage imageNamed:@"login_id.png"];
    UIView *idFieldImageContainer = [[UIView alloc] init];
    [idFieldImageContainer setFrame:CGRectMake(0.0f, 0.0f, 38, 38)];
    
    UIImageView *idIcon = [[UIImageView alloc] init];
    [idIcon setImage:idFieldImage];
    [idIcon setFrame:CGRectMake(0.0f, 4.0f, 30, 30)];
    
    [idFieldImageContainer addSubview:idIcon];
    
    [_idTextField setLeftView:idFieldImageContainer];
    [_idTextField setLeftViewMode:UITextFieldViewModeAlways];
    
    //pw field Setting
    UIImage *pwFieldImage = [UIImage imageNamed:@"login_pw.png"];
    UIView *pwFieldImageContainer = [[UIView alloc] init];
    [pwFieldImageContainer setFrame:CGRectMake(0.0f, 0.0f, 38, 38)];
    
    UIImageView *pwIcon = [[UIImageView alloc] init];
    [pwIcon setImage:pwFieldImage];
    [pwIcon setFrame:CGRectMake(0.0f, 4.0f, 30, 30)];
    
    [pwFieldImageContainer addSubview:pwIcon];
    
    [_pwTextField setLeftView:pwFieldImageContainer];
    [_pwTextField setLeftViewMode:UITextFieldViewModeAlways];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 디바이스 모델정보 가져오기
- (NSString *) getDeviceModel {
    
    NSDictionary *device_model = [NSDictionary dictionaryWithObjectsAndKeys:@"iPhone", @"iPhone1,1", @"iPhone3G", @"iPhone1,2", @"iPhone3GS", @"iPhone2,1", @"iPhone4(GSM)", @"iPhone3,1", @"iPhone4(CDMA)", @"iPhone3,3", @"iPhone4S", @"iPhone4,1", @"iPhone5(A1428)", @"iPhone5,1", @"iPhone5(A1429)", @"iPhone5,2", @"iPhone5c(A1456/A1532)", @"iPhone5,3", @"iPhone5c(A1507/A1516/A1529)", @"iPhone5,4", @"iPhone5s(A1433/A1453)", @"iPhone6,1", @"iPhone5s(A1457/A1518/A1530)", @"iPhone6,2", @"iPhone6Plus", @"iPhone7,1", @"iPhone6", @"iPhone7,2", @"iPhone6s", @"iPhone8,1", @"iPhone6sPlus", @"iPhone8,2", @"iPhoneSE", @"iPhone8,4", @"iPhone7(CDMA)", @"iPhone9,1", @"iPhone7(GSM)", @"iPhone9,3", @"iPhone7Plus(CDMA)", @"iPhone9,2", @"iPhone7Plus(GSM)", @"iPhone9,4", nil];
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *device_symbol = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSString *device_name = @"iPhone";
    
    for (NSString *key in device_model) {
        
        if ([key isEqualToString:device_symbol]) {
            
            device_name = device_model[device_symbol];
            break;
        }
    }
    
    return device_name;
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)clickAutoLoginButton:(id)sender {
    UIImage *autoLoginOffImage = [UIImage imageNamed:@"login_checkbox_off.png"];
    UIImage *autoLoginOnImage = [UIImage imageNamed:@"login_checkbox_on.png"];
    
    NSData *autoLoginClickImage = UIImagePNGRepresentation(_autoLoginImage.image);
    NSData *autoLoginOffImageData = UIImagePNGRepresentation(autoLoginOffImage);
    
    BOOL isCompare =  [autoLoginClickImage isEqual:autoLoginOffImageData];
    if(isCompare)
    {
        [_autoLoginImage setImage:autoLoginOnImage];
    }
    else
    {
        [_autoLoginImage setImage:autoLoginOffImage];
        NSLog(@"Image View doesn't contains image.png");
    }
}

- (IBAction)loginButtonAction:(id)sender {
    if([_idTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"아이디를 입력해주시기 바랍니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else if([_pwTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"비밀번호를 입력해주시기 바랍니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self showIndicator];
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:[_idTextField text] forKey:@"id"];
        [param setValue:_pwTextField.text forKey:@"password"];
        [param setValue:@"I" forKey:@"os_type"];
        [param setValue:@"" forKey:@"device_key"];
        [param setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"device_version"];
        [param setValue:[GlobalData sharedGlobalData].deviceToken forKey:@"apns_token"];
        
        [[MommyRequest sharedInstance] mommyLoginApiService:LoginCheck authKey:nil parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                NSDictionary *result = [[NSDictionary alloc] initWithDictionary:[data objectForKey:@"result"]];
                
                GET_AUTH_TOKEN = [result objectForKey:@"token"];
                GET_USER_ID = [result objectForKey:@"id"];
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    
                if([_autoLoginImage.image isEqual:[UIImage imageNamed:@"login_checkbox_off.png"]]){
                    [userDefaults setObject:@"N" forKey:@"autoLoginFlag"];
                }else{
                    [userDefaults setObject:@"Y" forKey:@"autoLoginFlag"];
                    [userDefaults setObject:_idTextField.text forKey:@"userId"];
                    [userDefaults setObject:_pwTextField.text forKey:@"userPw"];
                }
                
                [userDefaults synchronize];
                
                if([[result objectForKey:@"profile_yn"] isEqual:@"Y"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [appDelegate go_story_board:@"MainTabBar"];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"moveMommyInfoSegue" sender:self];
                    });
                }
                
            }else if([code isEqual:@"-1"]){
                //로그인 실패
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"로그인에 실패하셨습니다.\n다시 시도해주시기 바랍니다."
                                                                   delegate:self
                                                          cancelButtonTitle:@"취소"
                                                          otherButtonTitles:nil, nil];
                    //                [alert setTag:1];
                    [alert show];
                });
            }else if([code isEqual:@"-2"]){
                //등록된사용자 없음
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"등록된 사용자 정보가 없습니다.\n회원가입 화면으로 이동하시겠습니까?"                                   delegate:self                           cancelButtonTitle:@"취소"                              otherButtonTitles:@"이동", nil];
                    [alert setTag:2];
                    [alert show];
                });
                
            }else if([code isEqual:@"-3"]){
                //비밀번호 실패
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"비밀번호가 올바르지 않습니다.\n확인 후 다시 시도해 주세요."
                                                                   delegate:self
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles:nil, nil];
                    //                [alert setTag:3];
                    [alert show];
                });
            }else if([code isEqual:@"-4"]){
                //id잠김
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"사용자 계정이 잠금 처리 되었습니다.\n잠금해제 화면으로 이동하시겠습니까?"
                                                                   delegate:self
                                                          cancelButtonTitle:@"취소"
                                                          otherButtonTitles:@"잠금해제", nil];
                    
                    [alert setTag:4];
                    [alert show];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } error:^(NSError *error) {
            NSLog(@"PSH error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } ];
    }
//    NSDictionary *empty = [[NSDictionary alloc] init];
//    [[MommyRequest sharedInstance] mommySignInApiService:GetAddress authKey:nil parameters:empty success:^(NSDictionary *data){
//        NSLog(@"PSH data %@", data);        
//    } error:^(NSError *error) {
//        NSLog(@"PSH error %@", error);
//    } ];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch(alertView.tag) {
        case 2 : {
            if(buttonIndex == 1){ //"이동" pressed
//                UIStoryboard *signUpStoryboard = [UIStoryboard storyboardWithName:@"MembershipSignUp" bundle:nil];
//                UINavigationController *signUpNavigationController = (UINavigationController *)[signUpStoryboard instantiateViewControllerWithIdentifier:@"MembershipSignUpNavigation"];
//                
//                [self presentViewController:signUpNavigationController animated:YES completion:nil];
                [self performSegueWithIdentifier:@"moveSignUpSegue" sender:self];
            }
            break;
        }
        case 4 : {
            if(buttonIndex == 1){ //"잠금해제" pressed
                [self performSegueWithIdentifier:@"moveLoginUnlockAccountSegue" sender:self];
            }
            break;
        }
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moveLoginUnlockAccountSegue"])
    {
        LoginUnlockAccountController *vc = [segue destinationViewController];
        [vc setIdText:_idTextField.text];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
