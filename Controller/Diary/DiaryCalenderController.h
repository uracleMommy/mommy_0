 //
//  DiaryCalenderController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "DiaryListModel.h"
#import "CommonViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"

@protocol DiaryCalendarDelegate <NSObject>

@optional
-(void)moveCalendarMonthView:(NSDate *)date;
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;


@end

@interface DiaryCalenderController : CommonViewController <JTCalendarDelegate, DiaryListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableview;
@property (strong, nonatomic) DiaryListModel *diaryListTableController;
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) id<DiaryCalendarDelegate>delegate;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
