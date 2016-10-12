//
//  CommunityDetailController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ViewController.h"
#import "IQKeyboardManager.h"
#import "CommunityDetailModel.h"
#import "CommunityProfilePopupViewController.h"
#import "AppDelegate.h"
#import "CommonViewController.h"

@interface CommunityDetailController : CommonViewController <UITextViewDelegate, CommunityProfilePopupViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtMessageContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContainerHeight;
@property (assign) CGRect originalContentRect;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) CommunityDetailModel *tableListController;
@property (strong, nonatomic) CommunityProfilePopupViewController *profilePopupView;

@property (strong, nonatomic) NSString *communityKey;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *writerNickname;
@property (strong, nonatomic) NSString *writerImage;
@property (strong, nonatomic) NSString *writerKey;
@property (strong, nonatomic) NSString *regDate;
@property (strong, nonatomic) NSString *likeYN;


- (IBAction)likeButtonAction:(id)sender;
- (IBAction)insertReplyAction:(id)sender;

@end
