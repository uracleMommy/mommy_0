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
#import "CommunityNewspeedListController.h"
#import "AppDelegate.h"
#import "CommonViewController.h"
#define PAGE_SIZE [[NSNumber alloc] initWithInt:30]

@interface CommunityDetailController : CommonViewController <UITextViewDelegate, CommunityProfilePopupViewDelegate, CommunityDetailModelDelegate>

@property (weak, nonatomic) IBOutlet UITextView *txtMessageContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContainerHeight;
@property (assign) CGRect originalContentRect;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) CommunityDetailModel *tableListController;
@property (strong, nonatomic) CommunityProfilePopupViewController *profilePopupView;

@property (strong, nonatomic) NSDictionary *motherData;
@property (strong, nonatomic) NSNumber *searchPage;
@property (assign, nonatomic) Boolean currentLastPageStatus;
@property (strong, nonatomic) NSString *mento_id;
@property (strong, nonatomic) NSString *mento_nickname;


- (IBAction)likeButtonAction:(id)sender;
- (IBAction)insertReplyAction:(id)sender;

@end
