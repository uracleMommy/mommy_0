//
//  SleepingHoursViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"
#import "SleepingHoursModel.h"
@interface SleepingHoursViewController : CommonViewController<DZNSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *dayWeekTypeSegment;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) SleepingHoursModel *sleepingHoursModel;

- (IBAction)closeModal:(id)sender;

@end
