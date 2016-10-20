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
#import "CommonViewController.h"
#import "noDataDiaryController.h"

#define PAGE_SIZE [[NSNumber alloc] initWithInt:30]

@protocol DiaryListDelegate <NSObject>

@optional
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;
@end

@interface DiaryListController : CommonViewController <DiaryListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableview;
@property (strong, nonatomic) DiaryListModel *diaryListTableController;
@property (strong, nonatomic) id<DiaryListDelegate> delegate;
@property (strong, nonatomic) NSNumber *searchPage;
@property (strong, nonatomic) NSDate *selectedDate;
@property (assign, nonatomic) Boolean currentLastPageStatus;
@property (strong, nonatomic) noDataDiaryController *noDataController;

- (void)setListFirst:(NSDate *)date;

@end
