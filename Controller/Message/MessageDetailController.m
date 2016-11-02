//
//  MessageDetailController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageDetailController.h"
#import "MommyUtils.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"

@implementation MessageDetailController

static BOOL keyboardShow = NO;
static CGRect viewFrame;
static BOOL isFirstLoad;
const int containerViewHeight = 49;
const int messageViewHeight = 33;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self setKeyboardEnabled:NO];
    
    isFirstLoad = YES;
    
    _txtContentMessage.text = _contentMessage;
    _lblUserName.text = _toUserName;
    _lblDateTime.text = [[MommyUtils sharedGlobalData] getMommyDate:_writeTime];
    NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], _profileImageName];
    
    UIImage *profileImg = nil;
    NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
    profileImg = [[UIImage alloc] initWithData:firstImageData];
    if(profileImg != nil){
        [_imgProfile setImage:profileImg];
    }else{
        [_imgProfile setImage:[UIImage imageNamed:@"contents_profile_default"]];
    }
    _imgProfile.layer.cornerRadius = 20;
    _imgProfile.layer.masksToBounds = YES;

    // 백키 등록
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goPrevious) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
    
    // 키보드 매니저 업 이벤트 비활성화
    [self setKeyboardEnabled:NO];
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    // 점선처리
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:_infoContainerView.bounds];
    [shapeLayer setPosition:_infoContainerView.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    CGRect mainScreenRect = [[UIScreen mainScreen] bounds];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, mainScreenRect.size.width - 16.0, 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[_lblDotLine layer] addSublayer:shapeLayer];
    
    _txtMessageContent.delegate = self;
    
    // 키보드 노티피케이션
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    CALayer *border = [CALayer layer];
    border.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0] CGColor];
    border.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    border.borderWidth = 1.0f;
    [_textMessageView.layer addSublayer:border];
}

#pragma 뒤로가기
- (void) goPrevious {
    
    [self.navigationController popViewControllerAnimated:YES];
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
        self.navigationController.navigationBar.translucent = NO;
        NSLog(@"%f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, keyboardBounds.size.height);
        NSLog(@"%f", _originalContentRect.size.height);
        [self.view setFrame:CGRectMake(0, 64, self.view.frame.size.width, viewFrame.size.height - keyboardBounds.size.height)];
        
        keyboardShow = YES;
        
        
        
        // 텍스트뷰 길이 제조정
    }
    else if([notification name] == UIKeyboardWillHideNotification)
    {
        NSLog(@"%f, %f, %f, %f", viewFrame.origin.x, viewFrame.origin.y, viewFrame.size.width, viewFrame.size.height);
//        [self.view setFrame:viewFrame];
        
        [self.view setFrame:CGRectMake(viewFrame.origin.x, 64, viewFrame.size.width, viewFrame.size.height)];
        
        keyboardShow = NO;
    }
    
    [UIView commitAnimations];
}

#pragma 키보드 스타일 바뀔시에 높이 재조절
- (void) viewDidLayoutSubviews {
    
    if(isFirstLoad) {
        
        viewFrame = self.view.frame;
        isFirstLoad = NO;
    }
    
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

- (IBAction)pushMessage:(id)sender {
    
    // 길이 체크
    if (_txtMessageContent.text.length <= 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"내용을 입력해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAlertAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_toUserKey, @"to_user", _txtMessageContent.text, @"content", nil];
    
    [[MommyRequest sharedInstance] mommyMessageApiService:MessageSend authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
        
        
        if (data == nil) {
            
            // 실패처리
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"메세지 전송이 실패 했습니다.\n다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        if (data != nil) {
            
            long result = [data[@"code"] longValue];
            
            // 실패처리
            if (result != 0) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"메세지 전송이 실패 했습니다.\n다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                });
                return;
            }
            
            // 성공처리
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    } error:^(NSError *erro){
        
    }];
}

@end
