//
//  MessageListModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageListModel.h"
#import "MessageListCell.h"

@implementation MessageListModel

- (id) init {
    
    if (self = [super init]) {
        
        _listArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierNoticeCell = @"MessageListCell";
    
    UINib *reuseCell = [UINib nibWithNibName:@"MessageListCell" bundle:nil];
    [tableView registerNib:reuseCell forCellReuseIdentifier:CellIdentifierNoticeCell];
    
    MessageListCell *cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    
//    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
//    [alphaView setBackgroundColor:[UIColor blackColor]];
//    alphaView.alpha = 0.5f;
//    [cell.imgProfile addSubview:alphaView];
    
    [cell.imgProfile setImage:[UIImage imageNamed:@"contents_message_check"]];
    
    
    // 체크표시 넣기
    
    if (cell == nil) {
        
        cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 125.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // API 나오면 세부처리
    if ([self.delegate respondsToSelector:@selector(tableView:selectedRowIndex:)]) {
        [self.delegate tableView:tableView selectedRowIndex:1];
    }
    
    // 체크 표시 테이블뷰에서 셀 접근해서 바꿔주고 어레이안에 데이터들 체크표시 상태 바꿔주기
    
}

@end
