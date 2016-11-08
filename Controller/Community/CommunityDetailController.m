//
//  CommunityDetailController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityDetailController.h"
#define containerViewHeight 45
#define messageViewHeight 30

@interface CommunityDetailController ()

@end

@implementation CommunityDetailController

static BOOL keyboardShow = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchPage = [[NSNumber alloc] initWithInt:1];
    _currentLastPageStatus = NO;
    
    /** navigation Setting **/
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.hidesBackButton = YES;
    
    
    /** keypad Setting **/
    // 키보드 노티피케이션
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    /** table Setting **/
    _tableListController = [[CommunityDetailModel alloc] init];
    _tableListController.delegate = self;
    _tableView.delegate = _tableListController;
    _tableView.dataSource = _tableListController;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 60.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableListController.motherData = _motherData;
    [_tableView reloadData];
    
    
//    [self setReplyInfo];
    [self setListFirst];
}

- (void)viewDidAppear:(BOOL)animated{
    
    // 키보드 매니저 업 이벤트 비활성화
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"UnwindingSegue"]){
        CommunityNewspeedListController *vc = [segue destinationViewController];
        [vc setMode:MentorMode];
        [vc setTitleText:_mento_nickname];
        [vc setMentorKey:_mento_id];
    }
}



#pragma mark 키보드 show/hide 시에 처리되는 코드

#pragma 키보드 show/hide 노티
- (void)keyboardWillAnimate:(NSNotification *)notification {
    
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    if([notification name] == UIKeyboardWillShowNotification)
    {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, _originalContentRect.size.height - keyboardBounds.size.height)];
        
        keyboardShow = YES;
        
        // 텍스트뷰 길이 제조정
    }
    else if([notification name] == UIKeyboardWillHideNotification)
    {
        //[self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardBounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height + keyboardBounds.size.height)];
        
        keyboardShow = NO;
    }
    
    [UIView commitAnimations];
}

#pragma 키보드 스타일 바뀔시에 높이 재조절
- (void) viewDidLayoutSubviews {
    
    if (!keyboardShow) {
        
        _originalContentRect = self.view.frame;
        keyboardShow = YES;
    }
}

#pragma mark 키도드 메시지 박스 자동조절

#pragma 텍스트뷰 텍스트 체인지 콜백 함수(텍스트뷰 높이 조절 코드)
- (void) textViewDidChange:(UITextView *)textView {
    
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    if (newFrame.size.height < 83) {
        textView.frame = newFrame;
    }
    
    if (newFrame.size.height >= 33 && newFrame.size.height < 49) {
        _messageContainerHeight.constant = containerViewHeight;
    }
    else if (newFrame.size.height >= 49 && newFrame.size.height < 66) {
        _messageContainerHeight.constant = containerViewHeight + newFrame.size.height -  messageViewHeight;
    }
    else if (newFrame.size.height >= 66 && newFrame.size.height < 83) {
        _messageContainerHeight.constant = containerViewHeight + newFrame.size.height -  messageViewHeight;
    }
    else if (newFrame.size.height >= 83 && newFrame.size.height < 99) {
        _messageContainerHeight.constant = containerViewHeight + newFrame.size.height -  messageViewHeight;
    }
}

#pragma mark navigation Action
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark KkMenuPopup
- (void)moreButtonAction:(id)sender point:(CGPoint)point{
    NSLog(@"moreButton");
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"멘토추가"
                    target:self
                    action:@selector(addMentor:)],
      
      [KxMenuItem menuItem:@"삭제"
                    target:self
                    action:@selector(deleteMessage:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(point.x, point.y-_tableView.contentOffset.y, 0, 0)
     
                 menuItems:menuItems];
    
    [KxMenu setTarget:self action:@selector(dismissMenu)];
    
}

#pragma mark footer Button Action
- (IBAction)likeButtonAction:(id)sender {
    if([_likeButton.imageView.image isEqual:[UIImage imageNamed:@"comment_btn_like"]]){
        [_likeButton setImage:[UIImage imageNamed:@"comment_btn_like_on"] forState:UIControlStateNormal];
    }else{
        [_likeButton setImage:[UIImage imageNamed:@"comment_btn_like"] forState:UIControlStateNormal];
    }
}

- (IBAction)insertReplyAction:(id)sender {
    
    if([_txtMessageContent.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"내용을 입력해주세요."
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:[_motherData objectForKey:@"community_key"] forKey:@"community_upper_key"];
        [param setValue:_txtMessageContent.text forKey:@"content"];
        
        [self showIndicator];
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityInsertReply authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    _txtMessageContent.text = @"";
                    [self setListFirst];
                });
            }else{
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } error:^(NSError *error) {
            NSLog(@"PSH error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } ];
    }
}


#pragma mark profilePopup Action
-(void)showProfilePopupViewAction:(NSString *)personKey personNickname:(NSString *)personNickname{
    if (!_profilePopupView) {
        _profilePopupView = [[CommunityProfilePopupViewController alloc] initWithNibName:@"CommunityProfilePopupViewController" bundle:nil];
        _profilePopupView.delegate = self;
        _profilePopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    _profilePopupView.mentorNickname = personNickname;
    _profilePopupView.mentorKey = personKey;
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_profilePopupView.view];
}


- (void)moveWriteMessageViewAction:(id)sender{
    // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (void)moveNewspeedViewAction:(NSString *)mento_id mentoNickName:(NSString *)mento_nickname{
    NSLog(@"moveNewspeed");
    _mento_id = mento_id;
    _mento_nickname = mento_nickname;
    [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
}

#pragma mark tableView delegate
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    if (!_currentLastPageStatus) {
        return;
    }
    
    [self setListMore:[[NSNumber alloc] initWithInt:([_searchPage intValue]+[PAGE_SIZE intValue]) ]];
    
}

-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark
- (void)setReplyInfo{
    
    if([[_motherData objectForKey:@"like"] isEqualToString:@"Y"]){
        [_likeButton setImage:[UIImage imageNamed:@"comment_btn_like_on"] forState:UIControlStateNormal];
    }else{
        [_likeButton setImage:[UIImage imageNamed:@"comment_btn_like"] forState:UIControlStateNormal];
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:[_motherData objectForKey:@"community_key"] forKey:@"community_key"];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityReplyInfo authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            dispatch_sync(dispatch_get_main_queue(), ^{
                /** table Setting **/
                _tableListController = [[CommunityDetailModel alloc] init];
                _tableListController.delegate = self;
                _tableView.delegate = _tableListController;
                _tableView.dataSource = _tableListController;
                _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                _tableView.estimatedRowHeight = 60.0;
                _tableView.rowHeight = UITableViewAutomaticDimension;
                
//                _tableListController.replayInfo = [data objectForKey:@"result"];
                _tableListController.motherData = _motherData;
                [_tableView reloadData];
            });
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}

#pragma mark setting list
- (void)setListFirst{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:[_motherData objectForKey:@"community_key"] forKey:@"community_key"];
    
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityReplyInfo authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSDictionary *result = [data objectForKey:@"result"];
            _tableListController.replyInfo = result;
//            [_tableListController.replyInfo initWithDictionary:result];
        }
        
        
        [param setValue:PAGE_SIZE forKey:@"pageSize"];
        [param setValue:_searchPage forKey:@"searchPage"];
        
        [self showIndicator];
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityReplyList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                NSArray *result = [data objectForKey:@"result"];
                if([result count] == 0){
                    NSLog(@"empty");
                }else{
                    if([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= ([_searchPage intValue]+[PAGE_SIZE intValue]) ){
                        _currentLastPageStatus = YES;
                    }else{
                        _currentLastPageStatus = NO;
                    }
                    
                    [_tableListController.detailList removeAllObjects];
                    [_tableListController.detailList addObjectsFromArray:result];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tableView reloadData];
                    });
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } error:^(NSError *error) {
            NSLog(@"PSH error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } ];
        
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    }];
}


- (void)setListMore:(NSNumber *)searchPage{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:searchPage forKey:@"searchPage"];
    
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityReplyList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            _searchPage = searchPage;
            
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }else{
                if([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                    _currentLastPageStatus = YES;
                }else{
                    _currentLastPageStatus = NO;
                }
                
                [_tableListController.detailList addObjectsFromArray:result];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }
        }else{
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}

@end
