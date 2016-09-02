//
//  MessageListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageListController.h"
#import "MessageListCell.h"

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

- (void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath {
    
    if (_modifyStatus == ModifyMode) {
        
        NSMutableArray *listArray = _messageListModel.listArray;
        MessageListCell *cell = (MessageListCell *)[_tableView cellForRowAtIndexPath:indexPath];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contents_message_check"]];
        
        // 체크가 되어있는지 조사
        for (UIView *view in cell.imgProfile.subviews) {
            
            if (view.tag == 1) {
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", nil];
                [listArray replaceObjectAtIndex:indexPath.row withObject:dic];
                
                [view removeFromSuperview];
                return;
            }
        }
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"check", nil];
        [listArray replaceObjectAtIndex:indexPath.row withObject:dic];
        
        // 체크표시 추가
        img.tag = 1;
        [img setFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
        [cell.imgProfile addSubview:img];
        return;
    }
    
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
    }
    
    else {
        
        _modifyStatus = NormalMode;
        
        // 체크인덱스 초기화
        NSMutableArray *listArray = _messageListModel.listArray;
        
        for (int i = 0; i < listArray.count; i++) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", nil];
            [listArray replaceObjectAtIndex:i withObject:dic];
        }
    }
    
    _messageListModel.modifyStatus = _modifyStatus;
    [_tableView reloadData];
}

- (IBAction)closeView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end