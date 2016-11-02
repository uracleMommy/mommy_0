//
//  MessageDetailController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommonViewController.h"

@interface MessageDetailController : CommonViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@property (weak, nonatomic) IBOutlet UIView *infoContainerView;

@property (weak, nonatomic) IBOutlet UITextView *txtContentMessage;

@property (weak, nonatomic) IBOutlet UITextView *txtMessageContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContainerHeight;

@property (weak, nonatomic) IBOutlet UIView *textMessageView;

- (IBAction)pushMessage:(id)sender;

@property (strong, nonatomic) NSString *contentMessage;

@property (strong, nonatomic) NSString *profileImageName;

@property (strong, nonatomic) NSString *toUserName;

@property (strong, nonatomic) NSString *toUserKey;

@property (strong, nonatomic) NSString *writeTime;

@property (assign) CGRect originalContentRect;

@end
