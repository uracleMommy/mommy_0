//
//  MoreCalendarListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreCalendarListController.h"

@interface MoreCalendarListController ()

@end

@implementation MoreCalendarListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEnvironmentCalendarModal = [[MoreEnvironmentCalendarModal alloc] init];
    _tableView.dataSource = _moreEnvironmentCalendarModal;
    _tableView.delegate = _moreEnvironmentCalendarModal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
