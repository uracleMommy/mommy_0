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
    
    self.navigationItem.hidesBackButton = YES;
    
    [self showTermsPopup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    if(_termsPopupFlag){
        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:_termsPopupView.view];
    }
    scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMainScrollView"];

    [scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 680)];
    
    NSLog(@"%f %f", scrollViewContoller.view.frame.size.width, scrollViewContoller.view.frame.size.height);
    
    
    [_scrollView addSubview : scrollViewContoller.view];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 680);
    
    [_scrollView sizeToFit];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moveTermsView"])
    {
        SignUpAuthController *vc = [segue destinationViewController];
        [vc setType:_type];
    }
}


-(void) goBack{
    [scrollViewContoller.confirmNumberTimer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showTermsPopup {
    if (!_termsPopupView) {
        _termsPopupView = [[termsPopupViewController alloc] initWithNibName:@"termsPopupViewController" bundle:nil];
        _termsPopupView.delegate = self;
        _termsPopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_termsPopupView.view];
    _termsPopupFlag = YES;
}

- (void)cancleButtonAction{
    _termsPopupFlag = NO;
}

- (void)okButtonAction{
    _termsPopupFlag = NO;
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}

-(NSString *)getNumberStr:(NSString *)str
{
    //NSString *originalString = @"(123) 123123 abc";
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:str.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    //NSLog(@"%@", strippedString); // "123123123"
    return [NSString stringWithString:strippedString];
}


- (IBAction)nextButtonAction:(id)sender {
    
    //TODO 인증번호 체크
    NSArray *allTextFields = [self findAllTextFieldsInView:_scrollView];
    Boolean validationFlag = TRUE;
    
    for(int i=0 ; i<[allTextFields count] ; i++){
        if([[(UITextField*)[allTextFields objectAtIndex:i] text] isEqualToString:@""]){
            validationFlag = FALSE;
            break;
        }
    }
    if(validationFlag){
        for( int i=0 ; i<scrollViewContoller.idValidationArr.count ; i++){
            if([[scrollViewContoller.idValidationArr objectAtIndex:i] isEqualToString:@"N"]){
                validationFlag = FALSE;
                break;
            }
        }
    }
    if(validationFlag){
        for( int i=0 ; i<scrollViewContoller.passwordValidationArr.count ; i++){
            if([[scrollViewContoller.passwordValidationArr objectAtIndex:i] isEqualToString:@"N"]){
                validationFlag = FALSE;
                break;
            }
        }
    }
    
    if(validationFlag){
        [self showIndicator];
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        
        [param setValue:[scrollViewContoller.idTextField text] forKey:@"id"];
        [param setValue:[scrollViewContoller.passwordTextField text] forKey:@"password"];
        [param setValue:[scrollViewContoller.nameTextField text] forKey:@"name"];
        [param setValue:[self getNumberStr:[scrollViewContoller.birthdayTextField text] ] forKey:@"birth"];
        [param setValue:[scrollViewContoller.emailTextField text] forKey:@"email"];
        [param setValue:[scrollViewContoller.phoneNumberTextField text] forKey:@"phone_num"];
        
        [[MommyRequest sharedInstance] mommySignInApiService:MemberSignUp authKey:nil parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    //TODO 가입이 완료되었습니다. ~~~~~
                    [scrollViewContoller.confirmNumberTimer invalidate];
                    
                    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [appDelegate go_story_board:@"MembershipLogin"];
                });
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
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"입력하신 정보를 다시 확인 부탁드립니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)moveTermsView:(AuthTextType)type{
    _type = type;
    [self performSegueWithIdentifier:@"moveTermsView" sender:self];
}
@end
