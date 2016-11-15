//
//  DiaryCalenderController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryCalenderController.h"


static NSString *const kIssuer = @"https://accounts.google.com";
static NSString *const kClientID = @"644742492429-5sb4sosgqjr7ut4adj7816d477694p8d.apps.googleusercontent.com";
static NSString *const kRedirectURI =
@"com.googleusercontent.apps.644742492429-5sb4sosgqjr7ut4adj7816d477694p8d:/oauthredirect";
static NSString *const kExampleAuthorizerKey = @"authorization";


@interface DiaryCalenderController (){
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    
    NSDate *_dateSelected;
}

@end

@implementation DiaryCalenderController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self){
        return nil;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** taleView Setting **/
    _diaryListTableController = [[DiaryListModel alloc]init];
    _diaryListTableController.delegate = self;
    
    [_listTableview setDelegate:_diaryListTableController];
    [_listTableview setDataSource:_diaryListTableController];
    _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_listTableview reloadData];
    
    _searchPage = [[NSNumber alloc] initWithInt:1];
    _currentLastPageStatus = NO;
    
    
    /** calendarView Setting **/
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    _todayDate = [NSDate date];
    _eventsByDate = [[NSMutableDictionary alloc] init];
    
    [_calendarManager setContentView:_calendarContentView];
    
    self.service = [[GTLServiceCalendar alloc] init];

//    [_calendarManager setDate:_todayDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */


#pragma mark - google Calendar
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
        [self fetchEvents:_selectedDate];
    }else{
        if([self haveEventForDay:_dateSelected]){
            [self setListFirst:_dateSelected];
        }else{
            if(!_noDataController){
                _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                [_noDataController.view setFrame:CGRectMake(0, 0, _listView.frame.size.width, _listView.frame.size.height)];
                [_listView addSubview : _noDataController.view];
                _noDataController.view.hidden = NO;
            }else{
                _noDataController.view.hidden = NO;
            }
            _listTableview.hidden = YES;
        }
        [_calendarManager reload];
        [self hideIndicator];
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

- (void)fetchEvents:(NSDate *)date {
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsListWithCalendarId:@"primary"];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [cal components:(NSCalendarUnitWeekday|NSCalendarUnitSecond|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitYear ) fromDate:date];
    
    [dateComponents setDay:15];
    
    query.timeMin = [GTLDateTime dateTimeWithDate:[self addMonth:-1 date:[cal dateFromComponents:dateComponents]]
                                         timeZone:[NSTimeZone localTimeZone]];
    query.timeMax = [GTLDateTime dateTimeWithDate:[self addMonth:1 date:[cal dateFromComponents:dateComponents]]
                                         timeZone:[NSTimeZone localTimeZone]];
    query.singleEvents = YES;
    query.orderBy = kGTLCalendarOrderByStartTime;
    
    
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}


- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    if (error == nil) {
        _diaryListTableController.googleCalendarDic = [[NSMutableDictionary alloc] init];
        if (events.items.count > 0) {
            for (GTLCalendarEvent *event in events) {
                GTLDateTime *start = event.start.dateTime ?: event.start.date;
                GTLDateTime *end = event.end.dateTime ?: event.end.date;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"YYYYMMdd";
                NSCalendar *cal = [NSCalendar currentCalendar];
                
                NSDateComponents *comp = [cal components:NSDayCalendarUnit fromDate:[start date] toDate:[end date] options:0];
                
                for(int i=0 ; i<=comp.day; i++){
                    NSString *startString = [dateFormatter stringFromDate:[self addDay:i date:[start date]]];
                    [_googleCalendarData addObject:[event JSON]];
                    
                    if(!_diaryListTableController.googleCalendarDic[startString]){
                        _diaryListTableController.googleCalendarDic[startString] = [[NSMutableArray alloc] init];
                        [_diaryListTableController.googleCalendarDic[startString] addObject:[event JSON]];
                    }else{
                        [_diaryListTableController.googleCalendarDic[startString] addObject:[event JSON]];
                    }
                    
                    if(!_eventsByDate[startString]){
                        _eventsByDate[startString] = [[NSMutableDictionary alloc] initWithDictionary:[event JSON]];
                    }
                }
                
            }
            if([self haveEventForDay:_dateSelected]){
                [self setListFirst:_dateSelected];
            }else{
                if(!_noDataController){
                    _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                    [_noDataController.view setFrame:CGRectMake(0, 0, _listView.frame.size.width, _listView.frame.size.height)];
                    [_listView addSubview : _noDataController.view];
                    _noDataController.view.hidden = NO;
                }else{
                    _noDataController.view.hidden = NO;
                }
                _listTableview.hidden = YES;
            }
            [_calendarManager reload];
            [self hideIndicator];
        } else {
            if([self haveEventForDay:_dateSelected]){
                [self setListFirst:_dateSelected];
            }else{
                if(!_noDataController){
                    _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                    [_noDataController.view setFrame:CGRectMake(0, 0, _listView.frame.size.width, _listView.frame.size.height)];
                    [_listView addSubview : _noDataController.view];
                    _noDataController.view.hidden = NO;
                }else{
                    _noDataController.view.hidden = NO;
                }
                _listTableview.hidden = YES;
            }

            [_calendarManager reload];
            [self hideIndicator];
        }
    } else {
        if([self haveEventForDay:_dateSelected]){
            [self setListFirst:_dateSelected];
        }else{
            if(!_noDataController){
                _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                [_noDataController.view setFrame:CGRectMake(0, 0, _listView.frame.size.width, _listView.frame.size.height)];
                [_listView addSubview : _noDataController.view];
                _noDataController.view.hidden = NO;
            }else{
                _noDataController.view.hidden = NO;
            }
            _listTableview.hidden = YES;
        }
        [_calendarManager reload];
        [self hideIndicator];
    }
}



#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor whiteColor];
        dayView.circleView.layer.borderWidth = 1;
        dayView.circleView.layer.borderColor = [UIColor colorWithRed:132.0/255.0 green:68.0/255.0 blue:262.0/255.0 alpha:1.0].CGColor;
        dayView.textLabel.textColor = [UIColor colorWithRed:132.0/255.0 green:68.0/255.0 blue:262.0/255.0 alpha:1.0];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:132.0/255.0 green:68.0/255.0 blue:262.0/255.0 alpha:1.0];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.textLabel.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.textLabel.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1.0];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYYMMdd";
        
        NSString *key = [dateFormatter stringFromDate:dayView.date];
        
        if([_eventsByDate[key][@"emoticon_yn"] isEqualToString:@"Y"]){
            UIColor *dotColor;
            switch ([_eventsByDate[key][@"emoticon"] intValue]) {
                case 501:
                    dotColor = [UIColor colorWithRed:249.0f/255.0f green:103.f/255.0f blue:78.0f/255.0f alpha:1.0f];
                    break;
                case 502:
                    dotColor = [UIColor colorWithRed:249.0f/255.0f green:179.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
                    break;
                case 503:
                    dotColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
                    break;
                case 504:
                    dotColor = [UIColor colorWithRed:156.0f/255.0f green:113.0f/255.0f blue:228.0f/255.0f alpha:1.0f];
                    break;
                case 505:
                    dotColor = [UIColor colorWithRed:100.0f/255.0f green:140.0f/255.0f blue:226.0f/255.0f alpha:1.0f];
                    break;
                case 506:
                    dotColor = [UIColor colorWithRed:220.0f/255.0f green:82.0f/255.0f blue:82.0f/255.0f alpha:1.0f];
                    break;
                case 507:
                    dotColor = [UIColor colorWithRed:150.0f/255.0f green:183.0f/255.0f blue:55.0/255.0f alpha:1.0f];
                    break;
                default:
                    dotColor = [UIColor blackColor];
                    break;
            }
            dayView.dotView.backgroundColor = dotColor;
        }else if(![_eventsByDate[key][@"recurringEventId"] isEqual:[NSNull null]]){
            dayView.dotView.backgroundColor = [UIColor colorWithRed:112.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f];
        }else{
            dayView.dotView.backgroundColor = [UIColor blackColor];
        }
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

    
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }else{
        if([self haveEventForDay:dayView.date]){
            [self setListFirst:dayView.date];
        }else{
            if(!_noDataController){
                _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                [_noDataController.view setFrame:CGRectMake(0, 0, _listView.frame.size.width, _listView.frame.size.height)];
                [_listView addSubview : _noDataController.view];
                _noDataController.view.hidden = NO;
            }else{
                _noDataController.view.hidden = NO;
            }
            _listTableview.hidden = YES;
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement didLoadAnotherPage
-(void)calendarDidLoadNextPage:(JTCalendarManager *)calendar{
    [self moveCalendarMonthView:calendar.date];
}

-(void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar{
    [self moveCalendarMonthView:calendar.date];
}

-(void)moveCalendarMonthView:(NSData *)date{
    [_delegate moveCalendarMonthView:date];
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYYMMdd";
    
    NSString *key = [dateFormatter stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}


#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *) indexPath{
    [_delegate tableView:tableView selectedIndexPath:indexPath];
}

- (void)setListFirst:(NSDate *)date{
    _selectedDate = date;
    _searchPage = [[NSNumber alloc]initWithInt:1];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"YYYYMMdd"];
    [param setValue:[formatter2 stringFromDate:date] forKey:@"search_day"];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:_searchPage forKey:@"searchPage"];
    
    [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqualToString:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            if(![self haveEventForDay:date]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(!_noDataController){
                        _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                        [_noDataController.view setFrame:CGRectMake(0, 0, _listView.frame.size.width, _listView.frame.size.height)];
                        [_listView addSubview : _noDataController.view];
                        _noDataController.view.hidden = NO;
                    }else{
                        _noDataController.view.hidden = NO;
                    }
                    _listTableview.hidden = YES;
                });
            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    _listTableview.hidden = NO;
                    if(_noDataController){
                        _noDataController.view.hidden = YES;
                    }
                });
                [_diaryListTableController.diaryList removeAllObjects];
                [_diaryListTableController.diaryList addObjectsFromArray:result];
                
                if([result count] == 0 || [[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                    _currentLastPageStatus = YES;
                }else{
                    _currentLastPageStatus = NO;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _diaryListTableController.selectedDate = [formatter2 stringFromDate:date];
                    [_listTableview reloadData];
                    //                [self hideIndicator];
                });
            }
        }else{
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [self hideIndicator];
            //            });
        }
    } error:^(NSError *error) {
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [self hideIndicator];
        //        });
        
    }];
}

#pragma 테이블뷰 맨마지막 셀 도달시 추가 로드
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count {
    if (!_currentLastPageStatus) {
        return;
    }
    
    [self setListMore:_selectedDate searchPage:[[NSNumber alloc] initWithInt:([_searchPage intValue]+[PAGE_SIZE intValue]) ]];
}


- (void)setListMore:(NSDate *)date searchPage:(NSNumber *)searchPage{
    
    _selectedDate = date;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"YYYYMMdd"];
    [param setValue:[formatter2 stringFromDate:date] forKey:@"search_day"];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:searchPage forKey:@"searchPage"];
    
    [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqualToString:@"0"]){
            _searchPage = searchPage;
            
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            
            [_diaryListTableController.diaryList addObjectsFromArray:result];
            
            
            if([result count] == 0 || ([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue]) >= ([_searchPage intValue]+[PAGE_SIZE intValue])){
                _currentLastPageStatus = YES;
            }else{
                _currentLastPageStatus = NO;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _diaryListTableController.selectedDate = [formatter2 stringFromDate:date];
                [_listTableview reloadData];
            });
        }
    } error:^(NSError *error) {
    }];
}


- (NSDate *)addMonth:(int)addCount date:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:addCount];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

- (NSDate *)addDay:(int)addCount date:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:addCount];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

- (void)getMonthEmoticon:(NSDate *)date{
    //초기화
    _eventsByDate = [[NSMutableDictionary alloc] init];
    _googleCalendarData = [[NSMutableArray alloc] init];
    _diaryListTableController.googleCalendarDic = [[NSMutableDictionary alloc] init];
    _diaryListTableController.diaryList = [[NSMutableArray alloc] init];
    _selectedDate = date;
    
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"YYYYMM"];
    [param setValue:[formatter2 stringFromDate:date] forKey:@"search_month"];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyDiaryApiService:MonthEmoticon authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        if([data[@"code"] intValue] == 0){
            for(int i = 0 ; i < [data[@"result"] count] ; i++){
                NSDictionary *value = [data[@"result"] objectAtIndex:i];
                    NSString *key = value[@"reg_dttm"];
                    
                    if(!_eventsByDate[key]){
                        _eventsByDate[key] = [[NSMutableDictionary alloc] initWithDictionary:value];
                    }
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self loadState];
            });
        }
        else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self loadState];
            });
        }
    } error:^(NSError *error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self loadState];
        });
    }];
}

@end
