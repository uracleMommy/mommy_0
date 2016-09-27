//
//  MoreWeekCheckViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreWeekCheckModel.h"

@interface MoreWeekCheckViewController : CommonViewController<MoreWeekCheckModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreWeekCheckModel *moreWeekCheckModel;

@property (strong, nonatomic) NSArray *weekData;

- (IBAction)closeModal:(id)sender;

@end
