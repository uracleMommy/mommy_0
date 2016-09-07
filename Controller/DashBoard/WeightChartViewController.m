//
//  WeightChartViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightChartViewController.h"

@interface WeightChartViewController ()

@end

@implementation WeightChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    NSArray *items = @[@"일자별", @"주차별"];
    _dayWeekTypeSegment.items = items;
    
    _dayWeekTypeSegment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _dayWeekTypeSegment.delegate = self;
    _dayWeekTypeSegment.selectedSegmentIndex = 0;
    
    [_dayWeekTypeSegment setShowsCount:NO];
    
    
    
    // 테이블 바인드
    NSArray *arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    _weightChartModel = [[WeightChartModel alloc] init];
    _weightChartModel.arrayList = arrayList;
    
    _tableView.delegate = _weightChartModel;
    _tableView.dataSource = _weightChartModel;
    //[_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
        
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
