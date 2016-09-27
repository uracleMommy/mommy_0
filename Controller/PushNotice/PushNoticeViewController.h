//
//  PushNoticeViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "PushNoticeModel.h"

@interface PushNoticeViewController : CommonViewController<PushNoticeModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)closeView:(id)sender;

@end
