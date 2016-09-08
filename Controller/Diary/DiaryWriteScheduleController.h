//
//  DiaryWriteScheduleController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDownTextField.h"

@interface DiaryWriteScheduleController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, IQDropDownTextFieldDelegate, UITextViewDelegate>{
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
}

@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *timeButton;

@end
