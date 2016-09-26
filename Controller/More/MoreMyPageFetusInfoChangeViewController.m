//
//  MoreMyPageFetusInfoChangeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageFetusInfoChangeViewController.h"

@interface MoreMyPageFetusInfoChangeViewController ()

@end

@implementation MoreMyPageFetusInfoChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreMyPageFetusChangeModel = [[MoreMyPageFetusChangeModel alloc] init];
    _moreMyPageFetusChangeModel.arrayList = [NSArray arrayWithObjects:@"1", @"2", nil];
    _tableView.dataSource = _moreMyPageFetusChangeModel;
    _tableView.delegate = _moreMyPageFetusChangeModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
