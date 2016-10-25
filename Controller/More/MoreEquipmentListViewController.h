//
//  MoreEquipmentListViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreEquipmentModel.h"

@interface MoreEquipmentListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) MoreEquipmentListModel *moreEquipmentListModel;

@end
