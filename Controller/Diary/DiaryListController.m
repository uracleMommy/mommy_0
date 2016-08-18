//
//  DiaryListController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListController.h"

@interface DiaryListController ()

@end

@implementation DiaryListController

- (void)viewDidLoad {
    _diaryListTableDelegate = [[DiaryListModel alloc]init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_listTableview setDelegate:_diaryListTableDelegate];
    [_listTableview setDataSource:_diaryListTableDelegate];
    
    _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_listTableview reloadData];
    

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
