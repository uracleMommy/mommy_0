//
//  DiaryWriteScheduleController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryWriteScheduleController.h"

static NSString *const kExampleAuthorizerKey = @"authorization";

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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDateFormatter:formatter];
    [_dateButton setDelegate:self];
    [_dateButton setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton setInputTextFlag:YES];
    [_dateButton setDate:NSDate.date];
    _dateLabel.text = [formatter stringFromDate:NSDate.date];
    [_dateButton2 setDateFormatter:formatter];
    [_dateButton2 setDelegate:self];
    [_dateButton2 setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton2 setInputTextFlag:YES];
    [_dateButton2 setDate:NSDate.date];
    _dateLabel2.text = [formatter stringFromDate:NSDate.date];

    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    [_timeButton setTimeFormatter:formatter2];
    [_timeButton setDelegate:self];
    [_timeButton setDropDownMode:IQDropDownModeTimePicker];
    [_timeButton setInputTextFlag:YES];
    [_timeButton setDate:NSDate.date];
    _timeLabel.text = [formatter2 stringFromDate:NSDate.date];
    [_timeButton2 setTimeFormatter:formatter2];
    [_timeButton2 setDelegate:self];
    [_timeButton2 setDropDownMode:IQDropDownModeTimePicker];
    [_timeButton2 setInputTextFlag:YES];
    [_timeButton2 setDate:NSDate.date];
    _timeLabel2.text = [formatter2 stringFromDate:NSDate.date];
    
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    
    [_placeholderLabel setFont:[UIFont fontWithName:@"NanumBarunGothic" size:15]];
    _contentsTextView.delegate = self;
    
    [_contentsTextView addSubview:_placeholderLabel];
    [_contentsTextView setTextContainerInset:UIEdgeInsetsMake(8, -5, 0, 0)];
    
    self.service = [[GTLServiceCalendar alloc] init];
    
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

#pragma mark Navigation Button Action
- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveSchedule{
    if([_titleLabel.text isEqualToString:@""] || [_titleLabel.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"입력하신 내용을 다시 확인해주세요."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self loadState];
    }
    
}


- (void)loadState {
    GTMAppAuthFetcherAuthorization* authorization =
    [GTMAppAuthFetcherAuthorization authorizationFromKeychainForName:kExampleAuthorizerKey];
    [self setGtmAuthorization:authorization];
}

- (void)setGtmAuthorization:(GTMAppAuthFetcherAuthorization*)authorization {
    if ([_authorization isEqual:authorization]) {
        [self updateUI];
        return;
    }
    _authorization = authorization;
    [self stateChanged];
}


- (void)stateChanged {
    [self saveState];
    [self updateUI];
}

- (void)updateUI {
    if (_authorization.canAuthorize) {
        self.service.authorizer = [GTMAppAuthFetcherAuthorization authorizationFromKeychainForName:kExampleAuthorizerKey];
        //데이터 받아오기
        [self fetchEvents];
    }
}

- (void)saveState {
    if (_authorization.canAuthorize) {
        [GTMAppAuthFetcherAuthorization saveAuthorization:_authorization
                                        toKeychainForName:kExampleAuthorizerKey];
    } else {
        [GTMAppAuthFetcherAuthorization removeAuthorizationFromKeychainForName:kExampleAuthorizerKey];
    }
}

- (void)fetchEvents {
    
    GTLCalendarEvent *event = [GTLCalendarEvent new];
    
    [event setSummary:_titleLabel.text];
    
    if(![_contentsTextView.text isEqualToString:@""]){
        [event setDescriptionProperty:_contentsTextView.text];
    }
    
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc]init];
    [formatterMonth setDateFormat:@"YYYYMMdd"];
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc]init];
    [formatterTime setDateFormat:@"HHmm"];
    
    NSString *startDate = [NSString stringWithFormat:@"%@%@", [formatterMonth stringFromDate:_dateButton.date], [formatterTime stringFromDate:_timeButton.date]];
    
    
    NSString *endDate = [NSString stringWithFormat:@"%@%@", [formatterMonth stringFromDate:_dateButton2.date], [formatterTime stringFromDate:_timeButton2.date]];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    GTLDateTime *startDateTime = [GTLDateTime dateTimeWithDate:[dateFormatter dateFromString:startDate] timeZone:[NSTimeZone systemTimeZone]];
    GTLCalendarEventDateTime *start = [GTLCalendarEventDateTime new];
    [start setDateTime:startDateTime];
    [start setTimeZone:@"Asia/Seoul"];
    [event setStart:start];
    
    GTLDateTime *endDateTime = [GTLDateTime dateTimeWithDate:[dateFormatter dateFromString:endDate] timeZone:[NSTimeZone systemTimeZone]];
    GTLCalendarEventDateTime *end = [GTLCalendarEventDateTime new];
    [end setDateTime:endDateTime];
    [end setTimeZone:@"Asia/Seoul"];
    [event setEnd:end];
    
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsInsertWithObject:event calendarId:@"primary"];
    
    [self.service executeQuery:query delegate:self didFinishSelector:@selector(displayWritingFinish:finishedWithObject:error:)];
}


- (void)displayWritingFinish:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    [self goBack];
}




@end
