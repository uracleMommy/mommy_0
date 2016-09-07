//
//  ActiveMassController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassController.h"

@interface ActiveMassController ()

@end

@implementation ActiveMassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[@"일자별", @"주차별"];
    _dayWeekTypeSegment.items = items;
    
    _dayWeekTypeSegment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _dayWeekTypeSegment.delegate = self;
    _dayWeekTypeSegment.selectedSegmentIndex = 0;
    
    [_dayWeekTypeSegment setShowsCount:NO];
    
    _activeMassModel = [[ActiveMassModel alloc] init];
    
    _tableView.dataSource = _activeMassModel;
    _tableView.delegate = _activeMassModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
