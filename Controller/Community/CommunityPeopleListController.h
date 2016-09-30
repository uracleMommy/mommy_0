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

@interface CommunityPeopleListController : ViewController<CommunityPersonListModelDelegate, CommunityProfilePopupViewDelegate>

@property (strong, nonatomic) CommunityPersonListModel *tableListController;
@property (strong, nonatomic) CommunityProfilePopupViewController *profilePopupView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
