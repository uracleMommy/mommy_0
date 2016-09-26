//
//  MoreMyPagePasswordChangeViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreMyPageModel.h"

@interface MoreMyPagePasswordChangeViewController : UIViewController

- (IBAction)closeModal:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreMyPagePasswordChangeModel *moreMyPagePasswordChangeModel;

@end
