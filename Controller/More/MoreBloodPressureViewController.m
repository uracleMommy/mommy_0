//
//  MoreBloodPressureViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureViewController.h"

@interface MoreBloodPressureViewController ()

@end

@implementation MoreBloodPressureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreBloodPressureModel = [[MoreBloodPressureModel alloc] init];
    _moreBloodPressureModel.arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6",  nil];
    _tableView.dataSource = _moreBloodPressureModel;
    _tableView.delegate = _moreBloodPressureModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addHistory:(id)sender {
    
}

@end