//
//  MoreWeekCheckDetailViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 12..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreWeekDetailModel.h"

@interface MoreWeekCheckDetailViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreWeekDetailModel *moreWeekDetailModel;

@end
