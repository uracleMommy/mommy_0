//
//  PushNoticeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "PushNoticeViewController.h"


@interface PushNoticeViewController () 

@property (strong, nonatomic) PushNoticeModel *pushNoticeModel;

@end

@implementation PushNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pushNoticeModel = [[PushNoticeModel alloc] init];
    _pushNoticeModel.arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    _pushNoticeModel.delegate = self;
    _tableView.dataSource = _pushNoticeModel;
    _tableView.delegate = _pushNoticeModel;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma 테이블뷰 셀렉트 콜백
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"goDetail" sender:nil];
}

@end