//
//  DiaryWriteScheduleController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryWriteScheduleController.h"

@interface DiaryWriteScheduleController ()

@end

@implementation DiaryWriteScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //close Button Setting
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    //save Button Setting
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveSchedule) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    [_dateButton setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDateFormatter:formatter];
    [_dateButton setDelegate:self];
    
    [_dateButton setDate:NSDate.date];
    _dateLabel.text = [formatter stringFromDate:NSDate.date];
    
    [_timeButton setDropDownMode:IQDropDownModeTimePicker];
    [_timeButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    [_timeButton setTimeFormatter:formatter2];
    [_timeButton setDelegate:self];
    
    [_timeButton setDate:NSDate.date];
    _timeLabel.text = [formatter2 stringFromDate:NSDate.date];
    
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    
    [_placeholderLabel setFont:[UIFont fontWithName:@"NanumBarunGothic" size:15]];
    _contentsTextView.delegate = self;
    
    [_contentsTextView addSubview:_placeholderLabel];
    [_contentsTextView setTextContainerInset:UIEdgeInsetsMake(8, -5, 0, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextView Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    else{
        _placeholderLabel.hidden = YES;
    }
}

#pragma mark dateField & timeField
-(void)textField:(IQDropDownTextField*)textField didSelectItem:(NSString*)item{
    NSLog(@"selected : %@", item);
    if([textField isEqual:_dateButton]){
        _dateLabel.text = item;
    }else{
        _timeLabel.text = item;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveSchedule{
    
}

@end
