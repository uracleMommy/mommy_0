//
//  MessageWriteController.m
//  co.medisolution
//
//  Created by uracle on 2016. 10. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

/* params
 * toUserNickname : 받는사람 닉네임
 * toUserCode : 받는사람 코드
 **/

#import "MessageWriteController.h"

@interface MessageWriteController ()

@end

@implementation MessageWriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** navigation Setting **/
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"쪽지 보내기";
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backButton;
    
    /** placeholder Setting **/
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    [_placeholderLabel setFont:[UIFont fontWithName:@"NanumBarunGothic" size:15]];
    [_contentsTextView addSubview:_placeholderLabel];
    [_contentsTextView setTextContainerInset:UIEdgeInsetsMake(8, -5, 0, 0)];

    /** nickname Setting **/
    [_toUserButton setTitle:_toUserNickname forState:UIControlStateNormal];
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

#pragma mark UITextView Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    _contentsLengthLabel.text = [NSString stringWithFormat:@"%ld", (long)_contentsTextView.text.length];
    
    if(![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    else{
        _placeholderLabel.hidden = YES;
    }
}

#pragma mark navigation Action
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Buttons Action
- (IBAction)sendMessageAction:(id)sender {
    if(_contentsTextView.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"내용을 입력해주세요."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];

    }else{
        [self showIndicator];

        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:_toUserCode forKey:@"to_user"];
        [param setValue:_contentsTextView.text forKey:@"content"];
        
        [[MommyRequest sharedInstance] mommyMessageApiService:MessageSend authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"쪽지 보내기에 실패하였습니다."
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
   
    }}

- (IBAction)cancelAction:(id)sender {
    [self goBack];
}
@end
