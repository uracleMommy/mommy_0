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
#import "CommonViewController.h"
#import "CommunityPeopleListController.h"
#import "MessageWriteController.h"
#import "CommunityDetailController.h"
#import "MultiImageViewController.h"

#define PAGE_SIZE [[NSNumber alloc] initWithInt:30]

@interface CommunityNewspeedListController : CommonViewController <CommunityNewspeedListModelDelegate, CommunityProfilePopupViewDelegate>

@property (nonatomic, strong) UIButton *moveWriteViewButton;
@property (strong, nonatomic) CommunityNewspeedListModel *tableListController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CommunityProfilePopupViewController *profilePopupView;
@property (strong, nonatomic) MultiImageViewController *imageViewer;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *groupKey;
@property (strong, nonatomic) NSString *mentorKey;
@property (strong, nonatomic) NSString *groupValue;
@property (strong, nonatomic) NSNumber *searchPage;
@property (assign, nonatomic) Boolean currentLastPageStatus;
@property (assign, nonatomic) int cellTag;
@property (strong, nonatomic) NSDictionary *detailData;
@property (strong, nonatomic) UIViewController *noDataController;
@property (assign) ViewMode mode;


@end
