//
//  WeightChartViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"
#import "WeightChartModel.h"
#import "CommonViewController.h"

@interface WeightChartViewController : CommonViewController<DZNSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *dayWeekTypeSegment;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) WeightChartModel *weightChartModel;

- (IBAction)closeModal:(id)sender;

@end