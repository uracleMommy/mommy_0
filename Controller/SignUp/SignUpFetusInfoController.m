//
//  SignUpFetusInfoController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpFetusInfoController.h"

@interface SignUpFetusInfoController ()

@end

@implementation SignUpFetusInfoController

- (void)viewDidLoad {
    _fetusInfoTableDelegate = [[SignUpFetusInfoModel alloc]init];
    
    [super viewDidLoad];
    
    [_fetusInfoTableView setDelegate:_fetusInfoTableDelegate];
    [_fetusInfoTableView setDataSource:_fetusInfoTableDelegate];
    
    _fetusInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_fetusInfoTableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
