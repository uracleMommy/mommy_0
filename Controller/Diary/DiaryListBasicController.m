//
//  DiaryListBasicController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListBasicController.h"

@interface DiaryListBasicController ()

@end

@implementation DiaryListBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** navigation Setting **/
    [self.navigationItem setHidesBackButton:YES];
    
    //add Button
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_add.png"];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setImage:addBtnImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(showAddPopup) forControlEvents:UIControlEventTouchUpInside];
    
    [addBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    self.navigationItem.leftBarButtonItem = addButton;
    
    //message Button
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *messageBtnImage = [UIImage imageNamed:@"title_icon_message.png"];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    [messageBtn setImage:messageBtnImage forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(moveToMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *messageButton = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    //alarm Button
    UIButton *alarmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *alarmBtnImage = [UIImage imageNamed:@"title_icon_alarm.png"];
    alarmBtn.frame = CGRectMake(0, 0, 40, 40);
    [alarmBtn setImage:alarmBtnImage forState:UIControlStateNormal];
    [alarmBtn addTarget:self action:@selector(moveToAlarm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *alarmButton = [[UIBarButtonItem alloc] initWithCustomView:alarmBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, alarmButton, messageButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    /** searchPage setting **/
    _searchPage = [[NSNumber alloc] initWithInt:1];
    _listDate = [NSDate new];
}

-(void)viewDidAppear:(BOOL)animated{
    if(!_listViewController){
        _listViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DiaryListTableView"];
        _listViewController.delegate = self;
        [_listViewController.view setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        
        [_contentView addSubview : _listViewController.view];
        
        [self moveCalendarMonthView:_listDate];
    }else{
        [self moveCalendarMonthView:_listDate];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    NSLog(@"prepareForUnwind");
    NSString *restorationIdentifier = _contentView.subviews[0].restorationIdentifier;
    
    if([restorationIdentifier isEqualToString:@"tableView"]){
        [_listViewController setListFirst:_listDate];
    }else{
        [_calenderViewController getMonthEmoticon:_listDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showDetailListSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        DiaryDetailListController *vc = (DiaryDetailListController *)([navController viewControllers][0]);
        [vc setDiaryKey:_selectedDiaryKey];
    }else if([[segue identifier] isEqualToString:@"showDetailScheduleSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        DiaryDetailScheduleController *vc = (DiaryDetailScheduleController *)([navController viewControllers][0]);
        [vc setGoogleCalendarData:_selectedGoogleCalendarDic];
    }
}

#pragma mark KkMenuPopup (다이어리, 일정)
- (void)showAddPopup{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    UIImage *addImage = [UIImage imageNamed:@"title_icon_add.png"];
    UIImage *closeImage = [UIImage imageNamed:@"title_icon_close.png"];
    
    NSData *clickImage = UIImagePNGRepresentation([imageView currentImage]);
    NSData *addImageData = UIImagePNGRepresentation(addImage);
    
    if([clickImage isEqual:addImageData]){
        [imageView setImage:closeImage forState:UIControlStateNormal];
        
        NSArray *menuItems =
        @[
          [KxMenuItem menuItem:@"다이어리"
                        target:self
                        action:@selector(moveWriteDiary:)],
          
          [KxMenuItem menuItem:@"일정"
                        target:self
                        action:@selector(moveWriteSchedule:)],
          ];
        
        KxMenuItem *first = menuItems[0];
        first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
        first.alignment = NSTextAlignmentCenter;
        
        [KxMenu showMenuInView:self.view
                      fromRect:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y-10, 0, 0)
                     menuItems:menuItems];
        
        [KxMenu setTarget:self action:@selector(dismissMenu)];
        
    }else{
        [KxMenu dismissMenu];
        [imageView setImage:addImage forState:UIControlStateNormal];
    }
}

- (void)dismissMenu{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    [imageView setImage:[UIImage imageNamed:@"title_icon_add.png"] forState:UIControlStateNormal];
}

#pragma mark moveView Functions
- (void)moveWriteDiary:(id)sender{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    [imageView setImage:[UIImage imageNamed:@"title_icon_add.png"] forState:UIControlStateNormal];
    
    [self performSegueWithIdentifier:@"writeDiarySegue" sender:self];
}

- (void)moveWriteSchedule:(id)sender{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    [imageView setImage:[UIImage imageNamed:@"title_icon_add.png"] forState:UIControlStateNormal];
    
    [self performSegueWithIdentifier:@"writeDetailScheduleSegue" sender:self];
}

- (void)moveToMessage{
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (void)moveToAlarm{
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"PushNotice" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"PushListNavigation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

#pragma mark calendarView&ListView Swap
- (IBAction)changeListViewAction:(id)sender {
    if(!_calenderViewController){
        _calenderViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DiaryListCalenderView"];        
        [_calenderViewController.view setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        
        _calenderViewController.delegate = self;
        
        [_contentView.subviews[0] removeFromSuperview];
        
        [_contentView addSubview : _calenderViewController.view];
        
        [_changeListButton setImage:[UIImage imageNamed:@"tab_btn_list"] forState:UIControlStateNormal];
        
        [_calenderViewController.calendarManager setDate:_listDate];
    }else{
        NSString *restorationIdentifier = _contentView.subviews[0].restorationIdentifier;
        
       [_contentView.subviews[0] removeFromSuperview];
        if([restorationIdentifier isEqualToString:@"tableView"]){
            [_calenderViewController.calendarManager setDate:_listDate];
            [_contentView addSubview : _calenderViewController.view];
            [_changeListButton setImage:[UIImage imageNamed:@"tab_btn_list"] forState:UIControlStateNormal];
        }else{
            [_contentView addSubview : _listViewController.view];
            [_changeListButton setImage:[UIImage imageNamed:@"tab_btn_calendar"] forState:UIControlStateNormal];
        }
    }
    
    [self moveCalendarMonthView:_listDate];
}

#pragma month move action
- (void)moveCalendarMonthView:(NSDate *)date{
    _listDate = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월"];
    _dateLabel.text = [formatter stringFromDate:date];
    
    NSString *restorationIdentifier = _contentView.subviews[0].restorationIdentifier;
    
    if([restorationIdentifier isEqualToString:@"tableView"]){
        [_listViewController setListFirst:date];
    }else{
        [_calenderViewController getMonthEmoticon:date];
    }
}

- (IBAction)prevMonthButton:(id)sender {
    NSString *restorationIdentifier = _contentView.subviews[0].restorationIdentifier;

    if([restorationIdentifier isEqualToString:@"tableView"]){
        [self moveCalendarMonthView:[self addMonth:-1 date:_listDate]];
    }else{
        [_calenderViewController.calendarContentView loadPreviousPageWithAnimation];
    }
}
    
- (IBAction)nextMonthButton:(id)sender {
    NSString *restorationIdentifier = _contentView.subviews[0].restorationIdentifier;
    
    if([restorationIdentifier isEqualToString:@"tableView"]){
        [self moveCalendarMonthView:[self addMonth:1 date:_listDate]];
    }else{
        [_calenderViewController.calendarContentView loadNextPageWithAnimation];
    }
}

- (NSDate *)addMonth:(int)addCount date:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:addCount];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

#pragma tableView delegate
- (void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
    // 디테일 이동 로직
    if([tableView cellForRowAtIndexPath:indexPath].tag == 1){
        _selectedDiaryKey = [(DiaryListImageCustomCell *)[tableView cellForRowAtIndexPath:indexPath] diaryKey];
        [self performSegueWithIdentifier:@"showDetailListSegue" sender:nil];
    }else if([tableView cellForRowAtIndexPath:indexPath].tag == 0){
        _selectedDiaryKey = [(DiaryListBasicCustomCell *)[tableView cellForRowAtIndexPath:indexPath] diaryKey];
        [self performSegueWithIdentifier:@"showDetailListSegue" sender:nil];
    }else{
        _selectedGoogleCalendarDic = [(DiaryListBasicCustomCell *)[tableView cellForRowAtIndexPath:indexPath] googleCalendarDic];
        [self performSegueWithIdentifier:@"showDetailScheduleSegue" sender:nil];
    }

}


@end
