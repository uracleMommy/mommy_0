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
#import "GTMAppAuth.h"
#import "GTLCalendar.h"
#import "noDataDiaryController.h"

#define PAGE_SIZE [[NSNumber alloc] initWithInt:30]

@protocol DiaryCalendarDelegate <NSObject>

@optional
-(void)moveCalendarMonthView:(NSDate *)date;
-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;
//-(void)


@end

@interface DiaryCalenderController : CommonViewController <JTCalendarDelegate, DiaryListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableview;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (strong, nonatomic) NSNumber *searchPage;
@property (strong, nonatomic) NSDate *selectedDate;
@property (assign, nonatomic) Boolean currentLastPageStatus;
@property (strong, nonatomic) DiaryListModel *diaryListTableController;
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) id<DiaryCalendarDelegate>delegate;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) noDataDiaryController *noDataController;
@property (strong, nonatomic) NSMutableArray *googleCalendarData;

@property (nonatomic, strong) GTLServiceCalendar *service;
@property(nonatomic, nullable) GTMAppAuthFetcherAuthorization *authorization;

- (void)setListFirst:(NSDate *)date;
- (void)getMonthEmoticon:(NSDate *)date;



@end
