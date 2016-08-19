//
//  WeekProgramController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeekProgramController.h"

@interface WeekProgramController ()

@end

@implementation WeekProgramController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[@"건강", @"운동", @"영양"];
    
    _segment.items = items;
    
    // 132 68 240
    _segment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _segment.delegate = self;
    _segment.selectedSegmentIndex = 0;
    
//    [_segment setCount:@(12) forSegmentAtIndex:0];
//    [_segment setCount:@(11) forSegmentAtIndex:1];
//    [_segment setEnabled:YES forSegmentAtIndex:2];
    [_segment setShowsCount:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
