//
//  CommunityNewspeedListController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CommunityNewspeedListModel.h"
#import "CommunityProfilePopupViewController.h"

@interface CommunityNewspeedListController : ViewController<CommunityNewspeedListModelDelegate, CommunityProfilePopupViewDelegate>

@property (nonatomic, strong) UIButton *moveWriteViewButton;
@property (strong, nonatomic) CommunityNewspeedListModel *tableListController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CommunityProfilePopupViewController *profilePopupView;

@end
