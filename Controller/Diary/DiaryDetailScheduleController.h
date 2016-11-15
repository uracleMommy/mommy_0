//
//  DiaryDetailScheduleController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDownTextField.h"
#import "CommonViewController.h"
#import "GTLCalendar.h"
#import "GTMAppAuth.h"
#import "notPasteField.h"

@interface DiaryDetailScheduleController : CommonViewController <IQDropDownTextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *timeButton;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton2;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *timeButton2;
@property (strong, nonatomic) NSDictionary *googleCalendarData;
@property (weak, nonatomic) IBOutlet notPasteField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;

@property (nonatomic, strong) GTLServiceCalendar *service;
@property(nonatomic, nullable) GTMAppAuthFetcherAuthorization *authorization;

@property (assign, nonatomic) Boolean editFlag;


@end
