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
    
    // 편집모드
    _messageListModel = NormalMode;
    
    // 네비바 버튼 추가
    _messageListModel = [[MessageListModel alloc] init];
    for (int i = 0; i < 10; i++) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", nil];
        [_messageListModel.listArray addObject:dic];
    }
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

#pragma 셀 셀럭트 모드로 변환
- (IBAction)cellSelect:(id)sender {
    
    if (_modifyStatus == NormalMode) {
        
        _modifyStatus = ModifyMode;
        
        // 테이블 리로드 처리
        
        
    }
    else {
        
        _modifyStatus = NormalMode;
        
        // 테이블 리로드 처리
        
    }
}

@end