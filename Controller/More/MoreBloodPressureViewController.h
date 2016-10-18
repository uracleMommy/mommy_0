//
//  MoreBloodPressureViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreBloodPressureModel.h"

@interface MoreBloodPressureViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreBloodPressureModel *moreBloodPressureModel;

- (IBAction)addHistory:(id)sender;

@end
