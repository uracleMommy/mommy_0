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
    
    // 네비게이션 버튼 설정
    //title_icon_choice
    
    // 좌측버튼
    _btnCellMode = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_choice"];
    _btnCellMode.frame = CGRectMake(0, 0, 40, 40);
    [_btnCellMode setImage:addBtnImage forState:UIControlStateNormal];
    [_btnCellMode addTarget:self action:@selector(cellSelectMode) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:_btnCellMode];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
        
    // 우측버튼
    _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close"];
    _btnClose.frame = CGRectMake(0, 0, 40, 40);
    [_btnClose setImage:closeBtnImage forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:_btnClose];
    
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, closeButton]];
    
    // 편집모드(일반)
    _modifyStatus = NormalMode;
    _messageListModel = [[MessageListModel alloc] init];
    _messageListModel.modifyStatus = _modifyStatus;
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", @"1", @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyMessageApiService:MessageList authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    [self hideIndicator];
                return;
            }
            
            _dicData = [NSDictionary dictionaryWithDictionary:data];
            
            NSArray *resultArray = [NSArray arrayWithArray:_dicData[@"result"]];
            
            long totCnt = 0;
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray) {
                
                NSString *messageContent = dic[@"content"];
                NSString *fromNickname = dic[@"from_nickname"];
                NSString *fromUser = dic[@"from_user"];
                NSString *imgName = dic[@"img"];
                NSString *messageKey = dic[@"message_key"];
                NSString *regDttm = dic[@"reg_dttm"];
                NSString *toUser = dic[@"to_user"];
                totCnt = [dic[@"tot_cnt"] longValue] ;
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", nil];
                
                [_messageListModel.listArray addObject:newDic];
            }
            
            // 카운터 없으면 empty 분기
            if (totCnt <= 0) {
                
                // 네비게이션바 버튼 지우기
                [self.navigationItem setLeftBarButtonItems:nil];
                
                [self hideIndicator];
                [self performSegueWithIdentifier:@"goEmptyMessage" sender:nil];
                return;
            }
            
            _messageListModel.delegate = self;
            _tableView.dataSource = _messageListModel;
            _tableView.delegate = _messageListModel;
            [_tableView reloadData];
            
            _currentLastPageStatus = NO;
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        NSLog(@"%@", error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
        });
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

#pragma mark 테이블뷰 콜백 관련
#pragma 테이블뷰 행 선택
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
        
        _messageListModel.listArray = [NSMutableArray arrayWithArray:listArray];
        
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

#pragma 테이블뷰 맨마지막 셀 도달시 추가 로드
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count {
    
    if (_currentLastPageStatus) {
        
        return;
    }
    
    NSString *startPageIndex = [NSString stringWithFormat:@"%ld", (long)count];
        
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", startPageIndex, @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyMessageApiService:MessageList authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
        
        _dicData = [NSDictionary dictionaryWithDictionary:data];
        
        NSArray *resultArray = [NSArray arrayWithArray:_dicData[@"result"]];
        
        long totCnt = 0;
        
        // 데이터 형식 만들기
        for (NSDictionary *dic in resultArray) {
            
            NSString *messageContent = dic[@"content"];
            NSString *fromNickname = dic[@"from_nickname"];
            NSString *fromUser = dic[@"from_user"];
            NSString *imgName = dic[@"img"];
            NSString *messageKey = dic[@"message_key"];
            NSString *regDttm = dic[@"reg_dttm"];
            NSString *toUser = dic[@"to_user"];
            totCnt = [dic[@"tot_cnt"] longValue] ;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", nil];
            
            [_messageListModel.listArray addObject:dic];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 카운터 없으면 empty 분기
            if (totCnt <= 0) {
                
                _currentLastPageStatus = YES;
                [self hideIndicator];
                return;
            }
            
            _messageListModel.delegate = self;
            _tableView.dataSource = _messageListModel;
            _tableView.delegate = _messageListModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        NSLog(@"%@", error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
        });
    }];
}

#pragma 셀 셀럭트 모드로 변환
- (void) cellSelectMode {
    
    if (_modifyStatus == NormalMode) {
        
        _modifyStatus = ModifyMode;
        [_btnCellMode setImage:[UIImage imageNamed:@"title_icon_delete"] forState:UIControlStateNormal];
        [_btnCellMode removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [_btnCellMode addTarget:self action:@selector(deleteSelectedCell) forControlEvents:UIControlEventTouchUpInside];
        [_btnClose removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [_btnClose addTarget:self action:@selector(cellSelectMode) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else {
        
        _modifyStatus = NormalMode;
        [_btnCellMode setImage:[UIImage imageNamed:@"title_icon_choice"] forState:UIControlStateNormal];
        [_btnCellMode removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [_btnCellMode addTarget:self action:@selector(cellSelectMode) forControlEvents:UIControlEventTouchUpInside];
        [_btnClose removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [_btnClose addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
        
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

#pragma 선택 삭제
- (void) deleteSelectedCell {
    
    // 유효성 체크
    
    NSMutableArray *listArray = _messageListModel.listArray;
    int checkedCount = 0;
    for (NSDictionary *dic in listArray) {
        
        NSString *checked = dic[@"check"];
        if ([checked isEqualToString:@"1"]) {
            checkedCount++;
            break;
        }
    }
    
    if (checkedCount <= 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"삭제할 행을 선택해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAlertAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSMutableArray *deleteKey = [[NSMutableArray alloc] init];
    
    // 선택된 셀 가져오기
    for (NSDictionary *dic in listArray) {
        
        if ([dic[@"check"] isEqualToString:@"1"]) {
            
            [deleteKey addObject:dic[@"message_key"]];
        }
    }
    
    //^(UIAlertAction *action)
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"선택된 행을 삭제 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"예" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        // 좌측 액션 버튼 원상태로 돌리기
        [_btnCellMode setImage:[UIImage imageNamed:@"title_icon_choice"] forState:UIControlStateNormal];
        [_btnCellMode removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [_btnCellMode addTarget:self action:@selector(cellSelectMode) forControlEvents:UIControlEventTouchUpInside];
        [_btnClose removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [_btnClose addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
        _modifyStatus = NormalMode;
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:deleteKey, @"del_list", nil];
        
        // 삭제 처리
        [[MommyRequest sharedInstance] mommyMessageApiService:MessageDelegate authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data) {
            
            // 편집모드(일반)
            _messageListModel = NormalMode;
            _messageListModel = [[MessageListModel alloc] init];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"10", @"pageSize", @"1", @"searchPage", nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self showIndicator];
                
                [[MommyRequest sharedInstance] mommyMessageApiService:MessageList authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
                    
                    _dicData = [NSDictionary dictionaryWithDictionary:data];
                    
                    NSArray *resultArray = [NSArray arrayWithArray:_dicData[@"result"]];
                    
                    long totCnt = 0;
                    
                    // 데이터 형식 만들기
                    for (NSDictionary *dic in resultArray) {
                        
                        NSString *messageContent = dic[@"content"];
                        NSString *fromNickname = dic[@"from_nickname"];
                        NSString *fromUser = dic[@"from_user"];
                        NSString *imgName = dic[@"img"];
                        NSString *messageKey = dic[@"message_key"];
                        NSString *regDttm = dic[@"reg_dttm"];
                        NSString *toUser = dic[@"to_user"];
                        totCnt = [dic[@"tot_cnt"] longValue] ;
                        
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"check", messageContent, @"content", fromNickname, @"from_nickname", fromUser, @"from_user", imgName, @"img", messageKey, @"message_key", regDttm, @"reg_dttm", toUser, @"to_user", nil];
                        
                        [_messageListModel.listArray addObject:dic];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // 카운터 없으면 empty 분기
                        if (totCnt <= 0) {
                            
                            // 네비게이션바 버튼 지우기
                            [self.navigationItem setLeftBarButtonItems:nil];
                            
                            [self hideIndicator];
                            [self performSegueWithIdentifier:@"goEmptyMessage" sender:nil];
                            return;
                        }
                        
                        _messageListModel.delegate = self;
                        _tableView.dataSource = _messageListModel;
                        _tableView.delegate = _messageListModel;
                        [_tableView reloadData];
                        
                        [self hideIndicator];
                    });
                    
                } error:^(NSError *error){
                    
                    NSLog(@"%@", error);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self hideIndicator];
                    });
                }];
            });
            
        } error:^(NSError *error){
            
            NSLog(@"%@", error);
        }];
        
    }];
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"아니오" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:confirmAlertAction];
    [alert addAction:cancelAlertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goMessageDetail"]) {
        
        NSNumber *selectedIndex =(NSNumber *)sender;
//        NSArray *resultArray = _dicData[@"result"];
        NSDictionary *dic = _messageListModel.listArray[[selectedIndex integerValue]];
        MessageDetailController *messageDetailController = (MessageDetailController *)segue.destinationViewController;
        NSLog(@"%@", dic[@"content"]);
        messageDetailController.contentMessage = dic[@"content"];
        messageDetailController.profileImageName = dic[@"img"];
        messageDetailController.toUserName = dic[@"from_nickname"];
        messageDetailController.toUserKey = dic[@"from_user"];
        messageDetailController.writeTime = dic[@"reg_dttm"];
    }
}

@end
