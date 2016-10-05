//
//  MessageListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageListController.h"
#import "MessageDetailController.h"
#import "MessageListCell.h"

@interface MessageListController ()

@end

@implementation MessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 편집모드(일반)
    _messageListModel = NormalMode;
    _messageListModel = [[MessageListModel alloc] init];
    
    NSString *auth_key = @"Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJnb2dvanNzIiwic3ViIjoiZ29nb2pzcyIsImV4cCI6MTQ3NjAwNzgyOSwibmFtZSI6IuyhsOyKueyLnSIsImlhdCI6MTQ3NTE0MzgyOX0.Qzl27M2ye-2pfomvsS8W7dQin_404Ds3YkTVYur_2_4";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"10", @"pageSize", @"1", @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyMessageApiService:MessageList authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
        _dicData = [NSDictionary dictionaryWithDictionary:data];
        
        NSArray *resultArray = [NSArray arrayWithArray:_dicData[@"result"]];
        
        // 데이터 형식 만들기
        for (NSDictionary *dic in resultArray) {
            
            NSString *messageContent = dic[@"content"];
            NSString *fromNickname = dic[@"from_nickname"];
            NSString *fromUser = dic[@"from_user"];
            NSString *imgName = dic[@"img"];
            NSString *messageKey = dic[@"message_key"];
            NSString *regDttm = dic[@"reg_dttm"];
            NSString *toUser = dic[@"to_user"];
            NSString *totCnt = dic[@"tot_cnt"];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", totCnt, @"tot_cnt", nil];
            
            [_messageListModel.listArray addObject:dic];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _messageListModel.delegate = self;
            _tableView.dataSource = _messageListModel;
            _tableView.delegate = _messageListModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
        });
    }];
}

- (void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath {
    
    if (_modifyStatus == ModifyMode) {
        
        NSMutableArray *listArray = _messageListModel.listArray;
        MessageListCell *cell = (MessageListCell *)[_tableView cellForRowAtIndexPath:indexPath];
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contents_message_check"]];
        
        // 체크가 되어있는지 조사
        for (UIView *view in cell.imgProfile.subviews) {
            
            if (view.tag == 1) {
                
                NSDictionary *dic = listArray[indexPath.row];
                NSString *messageContent = dic[@"content"];
                NSString *fromNickname = dic[@"from_nickname"];
                NSString *fromUser = dic[@"from_user"];
                NSString *imgName = dic[@"img"];
                NSString *messageKey = dic[@"message_key"];
                NSString *regDttm = dic[@"reg_dttm"];
                NSString *toUser = dic[@"to_user"];
                NSString *totCnt = dic[@"tot_cnt"];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", totCnt, @"tot_cnt", nil];
                
                [listArray replaceObjectAtIndex:indexPath.row withObject:newDic];
                
                [view removeFromSuperview];
                return;
            }
        }
        
        NSDictionary *dic = listArray[indexPath.row];
        NSString *messageContent = dic[@"content"];
        NSString *fromNickname = dic[@"from_nickname"];
        NSString *fromUser = dic[@"from_user"];
        NSString *imgName = dic[@"img"];
        NSString *messageKey = dic[@"message_key"];
        NSString *regDttm = dic[@"reg_dttm"];
        NSString *toUser = dic[@"to_user"];
        NSString *totCnt = dic[@"tot_cnt"];
        
        NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", totCnt, @"tot_cnt", nil];
        
        [listArray replaceObjectAtIndex:indexPath.row withObject:newDic];
        
        // 체크표시 추가
        img.tag = 1;
        [img setFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
        [cell.imgProfile addSubview:img];
        return;
    }
    
    NSNumber *selectedIndex = [NSNumber numberWithInteger:indexPath.row];
    
    // 디테일 이동 로직
    [self performSegueWithIdentifier:@"goMessageDetail" sender:selectedIndex];
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
            
            NSDictionary *dic = listArray[i];
            NSString *messageContent = dic[@"content"];
            NSString *fromNickname = dic[@"from_nickname"];
            NSString *fromUser = dic[@"from_user"];
            NSString *imgName = dic[@"img"];
            NSString *messageKey = dic[@"message_key"];
            NSString *regDttm = dic[@"reg_dttm"];
            NSString *toUser = dic[@"to_user"];
            NSString *totCnt = dic[@"tot_cnt"];
            
            NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", totCnt, @"tot_cnt", nil];
            
            [listArray replaceObjectAtIndex:i withObject:newDic];
        }
    }
    
    _messageListModel.modifyStatus = _modifyStatus;
    [_tableView reloadData];
}

- (IBAction)closeView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goMessageDetail"]) {
        
        NSNumber *selectedIndex =(NSNumber *)sender;
        NSArray *resultArray = _dicData[@"result"];
        NSDictionary *dic = resultArray[[selectedIndex integerValue]];
        MessageDetailController *messageDetailController = (MessageDetailController *)segue.destinationViewController;
        NSLog(@"%@", dic[@"content"]);
        messageDetailController.contentMessage = dic[@"content"];
        messageDetailController.profileImageName = dic[@""];
        
    }
}

@end
