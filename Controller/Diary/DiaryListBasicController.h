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

@protocol DiaryListBasicDelegate <NSObject>

@optional
- (JTCalendarMenuView*)getCalenderDateView;

@end

@interface DiaryListBasicController : UIViewController<DiaryCalendarDelegate, DiaryListDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) DiaryListController *listViewController;
@property (strong, nonatomic) DiaryCalenderController *calenderViewController;
- (IBAction)changeListViewAction:(id)sender;
- (IBAction)prevMonthButton:(id)sender;
- (IBAction)nextMonthButton:(id)sender;

@end
