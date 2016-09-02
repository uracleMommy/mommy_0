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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
