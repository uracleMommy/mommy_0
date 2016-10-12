//
//  MessageWriteController.h
//  co.medisolution
//
//  Created by uracle on 2016. 10. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ViewController.h"
#import "CommonViewController.h"

@interface MessageWriteController : CommonViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) NSString *toUserCode;
@property (strong, nonatomic) NSString *toUserNickname;
@property (weak, nonatomic) IBOutlet UIButton *toUserButton;
@property (weak, nonatomic) IBOutlet UILabel *contentsLengthLabel;

- (IBAction)sendMessageAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
