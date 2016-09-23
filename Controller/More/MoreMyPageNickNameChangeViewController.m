//
//  MoreMyPageNickNameChangeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageNickNameChangeViewController.h"

@interface MoreMyPageNickNameChangeViewController ()

@end

@implementation MoreMyPageNickNameChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreMyNickNameChangeModel = [[MoreMyNickNameChangeModel alloc] init];
    _tableView.dataSource = _moreMyNickNameChangeModel;
    _tableView.delegate = _moreMyNickNameChangeModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
