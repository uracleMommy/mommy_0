//
//  MoreWeekCheckViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreWeekCheckModel.h"

@interface MoreWeekCheckViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreWeekCheckModel *moreWeekCheckModel;

@property (strong, nonatomic) NSArray *weekData;

@end
