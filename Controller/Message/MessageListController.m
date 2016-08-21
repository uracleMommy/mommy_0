//
//  MessageListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageListController.h"

@interface MessageListController ()

@end

@implementation MessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _messageListModel = [[MessageListModel alloc] init];
    _messageListModel.delegate = self;
    _tableView.dataSource = _messageListModel;
    _tableView.delegate = _messageListModel;
    [_tableView reloadData];
}

- (void) tableView:(UITableView *)tableView selectedRowIndex:(NSInteger)rowIndex {
    
    // 디테일 이동 로직
    [self performSegueWithIdentifier:@"goMessageDetail" sender:nil];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
