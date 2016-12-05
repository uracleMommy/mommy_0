//
//  DiaryListBasicController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryListModel.h"
#import "KxMenu.h"
#import "DiaryListController.h"
#import "DiaryCalenderController.h"
#import "CommonViewController.h"
#import "DiaryDetailListController.h"
#import "DiaryWriteScheduleController.h"
#import "DiaryDetailScheduleController.h"

#define PAGE_SIZE [[NSNumber alloc] initWithInt:30]

@protocol DiaryListBasicDelegate <NSObject>

@optional
- (JTCalendarMenuView*)getCalenderDateView;

@end

@interface DiaryListBasicController : CommonViewController <DiaryCalendarDelegate, DiaryListDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *changeListButton;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) DiaryListController *listViewController;
@property (strong, nonatomic) DiaryCalenderController *calenderViewController;
@property (strong, nonatomic) NSDate *listDate;
@property (strong, nonatomic) NSNumber *searchPage;
@property (strong, nonatomic) NSString *selectedDiaryKey;
@property (strong, nonatomic) NSDictionary *selectedGoogleCalendarDic;

- (IBAction)changeListViewAction:(id)sender;
- (IBAction)prevMonthButton:(id)sender;
- (IBAction)nextMonthButton:(id)sender;

@end
