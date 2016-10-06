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

- (void)goBack {
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
        
        [[MommyRequest sharedInstance] mommyLoginApiService:LoginCheck authKey:nil parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                NSDictionary *result = [[NSDictionary alloc] initWithDictionary:[data objectForKey:@"result"]];
                
                GET_AUTH_TOKEN = [result objectForKey:@"token"];
                
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
