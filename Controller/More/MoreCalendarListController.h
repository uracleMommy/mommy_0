//
//  MoreCalendarListController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEnvironmentModel.h"

@interface MoreCalendarListController : CommonViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreEnvironmentCalendarModal *moreEnvironmentCalendarModal;

@end
