//
//  MoreMainViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreMainModel.h"
#import "CommonViewController.h"
#import "MoreMyPageMasterViewController.h"
#import "MoreEnvironmentSetupViewController.h"

@interface MoreMainViewController : CommonViewController<MoreMainModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreMainModel *moreMainModel;
@property (strong, nonatomic) NSDictionary *myInfo;

@end
