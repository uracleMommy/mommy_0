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
    
    if (_modifyStatus == ModifyMode) {
        
        if (cell.imgProfile.subviews.count == 0) {
            
            UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
            alphaView.tag = 0;
            [alphaView setBackgroundColor:[UIColor blackColor]];
            alphaView.alpha = 0.7f;
            [cell.imgProfile addSubview:alphaView];
        }
        
        // 체크 로직
        // 해당로우의 체크값이 1일때
        NSDictionary *cellDic = _listArray[indexPath.row];
        if ([cellDic[@"check"] isEqualToString:@"1"]) {
            
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contents_message_check"]];
            img.tag = 1;
            [img setFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
            [cell.imgProfile addSubview:img];
        }
        else {
            
            for (UIView *subView in cell.imgProfile.subviews) {
                
                if (subView.tag == 1) {
                    
                    [subView removeFromSuperview];
                }
            }
        }
    }
    
    else {
        
        if (cell.imgProfile.subviews.count > 0) {
            
            for (UIView *subView in cell.imgProfile.subviews) {
                                
                [subView removeFromSuperview];
            }
        }
    }
    
//    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
//    [alphaView setBackgroundColor:[UIColor blackColor]];
//    alphaView.alpha = 0.5f;
//    [cell.imgProfile addSubview:alphaView];
    
//    [cell.imgProfile setImage:[UIImage imageNamed:@"contents_message_check"]];
    
    
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
    if ([self.delegate respondsToSelector:@selector(tableView:selectedIndexPath:)]) {
        
        [self.delegate tableView:tableView selectedIndexPath:indexPath];
    }
}

@end
