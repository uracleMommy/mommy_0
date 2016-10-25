//
//  WeekProgramController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"
#import "WeekProgramModel.h"

@interface WeekProgramController : CommonViewController<DZNSegmentedControlDelegate, WeekProgramModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segment;

@property (strong, nonatomic) WeekProgramModel *weekProgramModel;

@property (strong, nonatomic) NSString *weightStatusCode;

@property (assign, nonatomic) NSInteger mainSelectedIndex;

@property (assign, nonatomic) WeekProgramEnabledKind weekProgramEnabledKind;

@end
