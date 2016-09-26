//
//  MoreMyPagePasswordChangeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPagePasswordChangeViewController.h"

@interface MoreMyPagePasswordChangeViewController ()

@end

@implementation MoreMyPagePasswordChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreMyPagePasswordChangeModel = [[MoreMyPagePasswordChangeModel alloc] init];
    _tableView.dataSource = _moreMyPagePasswordChangeModel;
    _tableView.delegate = _moreMyPagePasswordChangeModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
