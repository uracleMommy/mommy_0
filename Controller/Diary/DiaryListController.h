//
//  DiaryListController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryListModel.h"

@interface DiaryListController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *listTableview;
@property (strong, nonatomic) DiaryListModel *diaryListTableDelegate;

@end
