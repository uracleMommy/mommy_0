 //
//  DiaryCalenderController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "CommonViewController.h"


@protocol DiaryCalendarDelegate <NSObject>

@optional
-(void)moveCalendarMonthView:(NSDate *)date;

@end

@interface DiaryCalenderController : CommonViewController <JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) id<DiaryCalendarDelegate>delegate;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
