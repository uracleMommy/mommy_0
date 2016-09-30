//
//  CommunityMentorController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityMentorController.h"

@interface CommunityMentorController ()

@end

@implementation CommunityMentorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableListController = [[CommunityPersonListModel alloc] init];
    _tableListController.addMentorButtonFlag = NO;
    _tableListController.delegate = self;
    _tableView.delegate = _tableListController;
    _tableView.dataSource = _tableListController;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
    [_delegate moveCommunityList];
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
