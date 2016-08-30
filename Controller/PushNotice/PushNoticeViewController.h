//
//  PushNoticeViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushNoticeModel.h"

@interface PushNoticeViewController : UIViewController<PushNoticeModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end