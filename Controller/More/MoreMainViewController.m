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
    
    _tableView.dataSource = _moreMainModel;
    _tableView.delegate = _moreMainModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
