//
//  MoreEnvironmentSetupViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreEnvironmentModel.h"

@interface MoreEnvironmentSetupViewController : UIViewController<MoreEnvironmentListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreEnvironmentListModel *moreEnvironmentListModel;

- (IBAction)closeModal:(id)sender;

@end
