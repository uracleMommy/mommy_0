//
//  MoreMainViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMainViewController.h"

@interface MoreMainViewController ()

@end

@implementation MoreMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreMainModel = [[MoreMainModel alloc] init];
    _moreMainModel.delegate = self;
    _tableView.dataSource = _moreMainModel;
    _tableView.delegate = _moreMainModel;
    
}

#pragma 선택된 테이블 콜백
- (void) selectedIndexPath:(NSInteger)index {
    
    if (index == 1) {
        
        [self performSegueWithIdentifier:@"goBloodPressure" sender:nil];
    }
    else if (index == 2) {
        
        [self performSegueWithIdentifier:@"goWeekCheckList" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end