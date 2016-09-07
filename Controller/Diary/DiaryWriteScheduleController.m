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
    UINavigationItem *newItem = [[UINavigationItem alloc]init];
    newItem.title = @"일정입력";
    
    //close Button Setting
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    newItem.rightBarButtonItem = closeButton;
    
    //save Button Setting
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveSchedule) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    newItem.leftBarButtonItem = saveButton;
    
    [_navigationBar setItems:@[newItem]];
    
    
    [_dateButton setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDateFormatter:formatter];
    [_dateButton setDelegate:self];
    
    
    [_timeButton setDropDownMode:IQDropDownModeTimePicker];
    [_timeButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    [_timeButton setTimeFormatter:formatter2];
    [_timeButton setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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