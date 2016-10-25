//
//  SleepingHoursViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SleepingHoursViewController.h"

@interface SleepingHoursViewController ()

@end

@implementation SleepingHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[@"일자별", @"주차별"];
    _dayWeekTypeSegment.items = items;
    
    _dayWeekTypeSegment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _dayWeekTypeSegment.delegate = self;
    _dayWeekTypeSegment.selectedSegmentIndex = 0;
    
    [_dayWeekTypeSegment setShowsCount:NO];
    
    [_dayWeekTypeSegment addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    
    _sleepingHoursModel = [[SleepingHoursModel alloc] init];
    _tableView.dataSource = _sleepingHoursModel;
    _tableView.delegate = _sleepingHoursModel;
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    
    [_dayWeekTypeSegment setFrame:CGRectMake(0, 0, screenSize.size.width, 44)];
}

- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    
    [control setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:15.0f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
