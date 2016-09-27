//
//  DiaryListController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryListModel.h"
#import "KxMenu.h"

@protocol DiaryListDelegate <NSObject>

@optional
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface DiaryListController : UIViewController<DiaryListModelDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTableview;
@property (strong, nonatomic) DiaryListModel *diaryListTableController;
@property (strong, nonatomic) id<DiaryListDelegate> delegate;

@end
