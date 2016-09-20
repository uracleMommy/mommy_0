 //
//  DiaryCalenderController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"


@interface DiaryCalenderController : UIViewController<JTCalendarDelegate>

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

//- (IBAction)closeView:(id)sender;

@end
