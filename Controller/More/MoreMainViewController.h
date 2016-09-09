//
//  MoreMainViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreMainModel.h"

@interface MoreMainViewController : UIViewController<MoreMainModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreMainModel *moreMainModel;

@end