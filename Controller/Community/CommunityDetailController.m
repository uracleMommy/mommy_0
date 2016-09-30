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
    
    
    // 키보드 노티피케이션
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _tableListController = [[CommunityDetailModel alloc] init];
    
    _tableListController.delegate = self;
    _tableView.delegate = _tableListController;
    _tableView.dataSource = _tableListController;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    
    // 키보드 매니저 업 이벤트 비활성화
    [[IQKeyboardManager sharedManager] setEnable:NO];
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

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


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

- (IBAction)likeButtonAction:(id)sender {
    if([_likeButton.imageView.image isEqual:[UIImage imageNamed:@"comment_btn_like"]]){
        [_likeButton setImage:[UIImage imageNamed:@"comment_btn_like_on"] forState:UIControlStateNormal];
    }else{
        [_likeButton setImage:[UIImage imageNamed:@"comment_btn_like"] forState:UIControlStateNormal];
    }
}

-(void)showProfilePopupViewAction:(id)sender{
    if (!_profilePopupView) {
        _profilePopupView = [[CommunityProfilePopupViewController alloc] initWithNibName:@"CommunityProfilePopupViewController" bundle:nil];
        _profilePopupView.delegate = self;
        _profilePopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_profilePopupView.view];
}


- (void)moveWriteMessageViewAction:(id)sender{
    // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (void)moveNewspeedViewAction:(id)sender{
    NSLog(@"moveNewspeed");    
}

@end
