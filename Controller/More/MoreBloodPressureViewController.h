//
//  MoreBloodPressureViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreBloodPressureModel.h"

@interface MoreBloodPressureViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreBloodPressureModel *moreBloodPressureModel;

- (IBAction)closeModal:(id)sender;

- (IBAction)addHistory:(id)sender;

@end