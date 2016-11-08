//
//  CommunityPeopleListController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CommunityPersonListModel.h"
#import "CommunityProfilePopupViewController.h"
#import "CommunityNewspeedListController.h"
#import "CommonViewController.h"

#define PAGE_SIZE [[NSNumber alloc] initWithInt:10]

@interface CommunityPeopleListController : CommonViewController <CommunityPersonListModelDelegate, CommunityProfilePopupViewDelegate>

@property (strong, nonatomic) CommunityPersonListModel *tableListController;
@property (strong, nonatomic) CommunityProfilePopupViewController *profilePopupView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *groupKey;
@property (strong, nonatomic) NSString *groupValue;
@property (strong, nonatomic) NSNumber *searchPage;
@property (assign, nonatomic) Boolean currentLastPageStatus;
@property (strong, nonatomic) NSString *mento_id;
@property (strong, nonatomic) NSString *mento_nickname;


@end
