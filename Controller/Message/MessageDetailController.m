//
//  MessageDetailController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageDetailController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"

@implementation MessageDetailController

static BOOL keyboardShow = NO;
const int containerViewHeight = 49;
const int messageViewHeight = 33;

- (void) viewDidLoad {
    
    [super viewDidLoad];

    // 키보드 매니저 업 이벤트 비활성화
//    [self setKeyboardEnabled:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];    
    
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

@end
