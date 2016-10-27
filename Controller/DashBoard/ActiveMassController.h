//
//  ActiveMassController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"
#import "ActiveMassModel.h"

@interface ActiveMassController : CommonViewController<DZNSegmentedControlDelegate, ActiveMassModelDelegate>

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *dayWeekTypeSegment;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) ActiveMassModel *activeMassModel;

- (IBAction)goExerciseTimer:(id)sender;

@property (assign, nonatomic) NSInteger currentPage;

@end
