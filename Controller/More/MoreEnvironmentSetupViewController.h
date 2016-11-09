//
//  MoreEnvironmentSetupViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEnvironmentModel.h"
#import "MoreMyPageMasterViewController.h"

@interface MoreEnvironmentSetupViewController : CommonViewController<MoreEnvironmentListModelDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreEnvironmentListModel *moreEnvironmentListModel;
@property (strong, nonatomic) NSDictionary *myPageInfo;

- (IBAction)closeModal:(id)sender;
- (IBAction)logoutButtonAction:(id)sender;

@end
