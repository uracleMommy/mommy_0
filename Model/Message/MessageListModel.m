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
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierNoticeCell = @"MessageListCell";
    
    UINib *reuseCell = [UINib nibWithNibName:@"MessageListCell" bundle:nil];
    [tableView registerNib:reuseCell forCellReuseIdentifier:CellIdentifierNoticeCell];
    
    MessageListCell *cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    
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
}

@end
