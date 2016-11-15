//
//  DiaryDetailScheduleController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryDetailScheduleController.h"

static NSString *const kExampleAuthorizerKey = @"authorization";

@interface DiaryDetailScheduleController ()

@end

@implementation DiaryDetailScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** Navigation Setting **/
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    //edit Button Setting
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editBtnImage = [UIImage imageNamed:@"title_icon_edit.png"];
    editBtn.frame = CGRectMake(0, 0, 40, 40);
    [editBtn setImage:editBtnImage forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editSchedule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    //delete Button Setting
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteBtnImage = [UIImage imageNamed:@"title_icon_delete.png"];
    deleteBtn.frame = CGRectMake(0, 0, 40, 40);
    [deleteBtn setImage:deleteBtnImage forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteSchedule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, deleteButton, editButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    
    
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
    _placeholderLabel.hidden = YES;
    
    [_contentsTextView addSubview:_placeholderLabel];
    [_contentsTextView setTextContainerInset:UIEdgeInsetsMake(8, -5, 0, 0)];
    
    self.service = [[GTLServiceCalendar alloc] init];
    _editFlag = NO;
    
    [self loadState];
    [self initSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 0){
        switch (buttonIndex) {
            case 1 : {
                [self deleteEvents];
                break;
            }
                
            default:
                break;
        }
    }
}


#pragma mark UITextView Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if(_editFlag){
        if (![textView hasText]) {
            _placeholderLabel.hidden = NO;
        }
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_editFlag){
        if(![textView hasText]) {
            _placeholderLabel.hidden = NO;
        }
        else{
            _placeholderLabel.hidden = YES;
        }
    }
}

#pragma mark dateField & timeField
-(void)textField:(IQDropDownTextField*)textField didSelectItem:(NSString*)item{
    if([textField isEqual:_dateButton]){
        _dateLabel.text = item;
    }else if([textField isEqual:_timeButton]){
        _timeLabel.text = item;
    }else if([textField isEqual:_dateButton2]){
        _dateLabel2.text = item;
    }else{
        _timeLabel2.text = item;
    }
}

#pragma mark Navigation Button Action
- (void)goBack{
    if(_editFlag){
        [self toDisabled];
        [self initSchedule];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)deleteSchedule{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                    message:@"일정을 삭제하시겠습니까?"
                                                   delegate:self
                                          cancelButtonTitle:@"취소"
                                          otherButtonTitles:@"삭제", nil];
    alert.tag = 0;
    [alert show];
}

- (void)editSchedule{
    _editFlag = YES;
    [self toEdit];
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
        [self updateEvents];
    }
    
}

#pragma mark switchMode
- (void)toEdit{
    /** Navigation Setting **/
    self.navigationItem.title = @"일정 수정";
    //close Button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItems = @[closeButton];
    
    //save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveSchedule) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    NSArray *allTextFields = [self findAllTextFieldsInView:self.view];
    for(int i=0 ; i<[allTextFields count] ; i++){
        [[allTextFields objectAtIndex:i] setUserInteractionEnabled:YES];
    }
}

- (void)toDisabled{
    _editFlag = NO;
    /** Navigation Setting **/
    self.navigationItem.title = @"일정 상세";
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //edit Button Setting
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editBtnImage = [UIImage imageNamed:@"title_icon_edit.png"];
    editBtn.frame = CGRectMake(0, 0, 40, 40);
    [editBtn setImage:editBtnImage forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editSchedule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    //delete Button Setting
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteBtnImage = [UIImage imageNamed:@"title_icon_delete.png"];
    deleteBtn.frame = CGRectMake(0, 0, 40, 40);
    [deleteBtn setImage:deleteBtnImage forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteSchedule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, deleteButton, editButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    NSArray *allTextFields = [self findAllTextFieldsInView:self.view];
    for(int i=0 ; i<[allTextFields count] ; i++){
        [[allTextFields objectAtIndex:i] setUserInteractionEnabled:NO];
    }
}


#pragma
-(void)initSchedule{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    
    if(_googleCalendarData[@"start"][@"dateTime"] != nil){
        _dateLabel.text = [self getyyyyMMddeeee:_googleCalendarData[@"start"][@"dateTime"]];
        [_dateButton setDate:[formatter dateFromString:[self getyyyyMMddeeee:_googleCalendarData[@"start"][@"dateTime"]]]];
        
        [_timeButton setDate:[formatter2 dateFromString:[self getHHmm:_googleCalendarData[@"start"][@"dateTime"]]]];
        _timeLabel.text = [self getHHmm:_googleCalendarData[@"start"][@"dateTime"]];

        
    }else{
        _dateLabel.text = [self getyyyyMMddeeee2:_googleCalendarData[@"start"][@"date"]];
        [_dateButton setDate:[formatter dateFromString:[self getyyyyMMddeeee2:_googleCalendarData[@"start"][@"date"]]]];
        
        [_timeButton setDate:[formatter2 dateFromString:@"00:01"]];
        _timeLabel.text = @"00:01";
    }
    
    if(_googleCalendarData[@"end"][@"dateTime"] != nil){
        _dateLabel2.text = [self getyyyyMMddeeee:_googleCalendarData[@"end"][@"dateTime"]];
        [_dateButton2 setDate:[formatter dateFromString:[self getyyyyMMddeeee:_googleCalendarData[@"end"][@"dateTime"]]]];
        [_timeButton2 setDate:[formatter2 dateFromString:[self getHHmm:_googleCalendarData[@"end"][@"dateTime"]]]];
        _timeLabel2.text = [self getHHmm:_googleCalendarData[@"end"][@"dateTime"]];
    }else{
        _dateLabel2.text = [self getyyyyMMddeeee2:_googleCalendarData[@"end"][@"date"]];
        [_dateButton2 setDate:[formatter dateFromString:[self getyyyyMMddeeee2:_googleCalendarData[@"end"][@"date"]]]];
        [_timeButton2 setDate:[formatter2 dateFromString:@"23:59"]];
        _timeLabel2.text = @"23:59";
    }
    
    _titleLabel.text = [_googleCalendarData objectForKey:@"summary"];
    
    if(_googleCalendarData[@"description"] != nil){
        _contentsTextView.text = _googleCalendarData[@"description"];
    }else{
        _contentsTextView.text = _googleCalendarData[@"summary"];
    }
}

#pragma mark utils
- (NSString *) getyyyyMMddeeee : (NSString *) dateFormatString {
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    NSString *yyyymmddeeee = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmddeeee;
}


- (NSString *) getyyyyMMddeeee2 : (NSString *) dateFormatString {
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    NSString *yyyymmddeeee = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmddeeee;
}

- (NSString *) getHHmm : (NSString *) dateFormatString {
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *HHmm = [dateFormatter stringFromDate:dateFromString];
    
    return HHmm;
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x isKindOfClass:[UITextView class]])
            [textfieldarray addObject:x];
        
        if([x isKindOfClass:[UIButton class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
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

- (void)deleteEvents {
    
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsDeleteWithCalendarId:@"primary" eventId:_googleCalendarData[@"id"]];
    query.singleEvents = YES;
    
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(displayDeleteWithTicket:finishedWithObject:error:)];
}


- (void)displayDeleteWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    if(error == nil){
        [self goBack];
    }
}

- (void)updateEvents {
    
    GTLCalendarEvent *event = [GTLCalendarEvent new];
    
    [event setSummary:_titleLabel.text];
    [event setDescriptionProperty:_contentsTextView.text];
    
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
    
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsUpdateWithObject:event calendarId:@"primary" eventId:_googleCalendarData[@"id"]];
    
    [self.service executeQuery:query delegate:self didFinishSelector:@selector(displayUpdateWithTicket:finishedWithObject:error:)];
}


- (void)displayUpdateWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    if(error == nil){
        [self toDisabled];
    }
}






@end
