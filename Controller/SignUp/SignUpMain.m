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
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
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

-(void)viewDidAppear:(BOOL)animated{
    scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMainScrollView"];

    [scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 680)];
    
    NSLog(@"%f %f", scrollViewContoller.view.frame.size.width, scrollViewContoller.view.frame.size.height);
    
    
    [_scrollView addSubview : scrollViewContoller.view];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 680);
    
    [_scrollView sizeToFit];
}

/*
#pragma mark - Navigationf

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showTermsPopup:(id)sender {
    if (!_termsPopupView) {
        _termsPopupView = [[termsPopupViewController alloc] initWithNibName:@"termsPopupViewController" bundle:nil];
        _termsPopupView.delegate = self;
        _termsPopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_termsPopupView.view];
}

- (void)cancleButtonAction{
    
}

- (void)okButtonAction{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setValue:[scrollViewContoller.idTextField text] forKey:@"id"];
    [param setValue:[scrollViewContoller.passwordTextField text] forKey:@"password"];
    [param setValue:[scrollViewContoller.nameTextField text] forKey:@"name"];
    [param setValue:[scrollViewContoller.birthdayTextField text] forKey:@"birth"];
    [param setValue:[scrollViewContoller.emailTextField text] forKey:@"email"];
    [param setValue:[scrollViewContoller.phoneNumberTextField text] forKey:@"phone_num"];

    //TODO validation check
    [self showIndicator];
    [[MommyRequest sharedInstance] mommySignInApiService:MemberSignUp authKey:nil parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            [self performSegueWithIdentifier:@"moveMommyInfoSegue" sender:self];
        }else if([code isEqual:@"-11"]){
            //아이디 중복 에러
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"아이디가 이미 존재합니다.\n다시 확인해주시기 바랍니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            });
        }else if([code isEqual:@"-12"]){
            //휴대번호 중복 에러
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"휴대번호가 이미 존재합니다.\n다시 확인해주시기 바랍니다."                                   delegate:self                           cancelButtonTitle:@"확인"                              otherButtonTitles:nil, nil];
                [alert show];
            });
            
        }else if([code isEqual:@"-13"]){
            //닉네임 중복 에러
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:@"닉네임이 이미 존재합니다.\n다시 확인해주시기 바랍니다."
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
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


@end
