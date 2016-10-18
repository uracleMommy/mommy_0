//
//  MoreMyPagePointViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreMyPageModel.h"

@interface MoreMyPagePointViewController : CommonViewController<MoreMyPageModelDelegate>

@property (weak, nonatomic) IBOutlet UIView *pointContainerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)closeModal:(id)sender;

@property (strong, nonatomic) MoreMyPagePointModel *moreMyPagePointModel;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalPoint;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
