//
//  MoreWeekCheckDetailViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 12..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreWeekCheckDetailViewController.h"

@interface MoreWeekCheckDetailViewController ()

@end

@implementation MoreWeekCheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arrayData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    _moreWeekDetailModel = [[MoreWeekDetailModel alloc] init];
    _moreWeekDetailModel.arrayList = [NSArray arrayWithArray:arrayData];
    _tableView.dataSource = _moreWeekDetailModel;
    _tableView.delegate = _moreWeekDetailModel;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
