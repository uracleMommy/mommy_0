//
//  MoreWeekCheckViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreWeekCheckViewController.h"

@interface MoreWeekCheckViewController ()

@end

@implementation MoreWeekCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 데이터 만들기
    NSString *title1 = @"임신 초기";
    NSString *title2 = @"임신 중기";
    NSString *title3 = @"임신 말기";
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"1주~4주차", @"title", @"아직 임신이 되었는지 알 수 없어요.", @"content", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"5주차", @"title", @"아기집이 보여요~!", @"content", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"6주차", @"title", @"아기가 보여요.", @"content", nil];
    NSArray *data1 = [NSArray arrayWithObjects:dic1, dic2, dic3, nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"13주차", @"title", @"움직임이 더 활발해 집니다.", @"content", nil];
    NSArray *data2 = [NSArray arrayWithObjects:dic4, nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"36주차", @"title", @"곧 나옵니다.", @"content", nil];
    NSArray *data3 = [NSArray arrayWithObjects:dic5, nil];
    
    _weekData = [NSArray arrayWithObjects:title1, data1, title2, data2, title3, data3, nil];
    
    _moreWeekCheckModel = [[MoreWeekCheckModel alloc] init];
    _moreWeekCheckModel.delegate = self;
    _moreWeekCheckModel.arrayList = [NSArray arrayWithArray:_weekData];
    _tableView.dataSource = _moreWeekCheckModel;
    _tableView.delegate = _moreWeekCheckModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tableView:(UITableView *)tableView selectedRowIndex:(NSInteger)index {
    
    [self performSegueWithIdentifier:@"goDetailWeekCheck" sender:nil];
}

@end