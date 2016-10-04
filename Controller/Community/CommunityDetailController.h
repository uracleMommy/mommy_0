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

- (IBAction)likeButtonAction:(id)sender;

@end
