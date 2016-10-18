//
//  MoreMyPageModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageModel.h"
#import "MommyUtils.h"
#pragma mark 닉네임 변경 모델
@implementation MoreMyNickNameChangeModel

- (id) init {
    
    if (self = [super init]) {
        
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreMyPageNickNameCell = @"MoreMyPageNickNameCell";
    
    UINib *reuseMoreMyPageNickNameCell = [UINib nibWithNibName:@"MoreMyPageNickNameCell" bundle:nil];
    [tableView registerNib:reuseMoreMyPageNickNameCell forCellReuseIdentifier:CellIdentifierMoreMyPageNickNameCell];
    
    MoreMyPageNickNameCell *cell = (MoreMyPageNickNameCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageNickNameCell];
    
    if (cell == nil) {
        
        cell = (MoreMyPageNickNameCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageNickNameCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

#pragma 닉네임 변경 터치
- (void) NickNameTouch {
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

#pragma mark 비밀번호 변경 모델
@implementation MoreMyPagePasswordChangeModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreMyPagePasswordChangeCell = @"MoreMyPagePasswordChangeCell";
    
    UINib *reuseMoreMyPagePasswordChangeCell = [UINib nibWithNibName:@"MoreMyPagePasswordChangeCell" bundle:nil];
    [tableView registerNib:reuseMoreMyPagePasswordChangeCell forCellReuseIdentifier:CellIdentifierMoreMyPagePasswordChangeCell];
    
    MoreMyPagePasswordChangeCell *cell = (MoreMyPagePasswordChangeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPagePasswordChangeCell];
    
    if (cell == nil) {
        
        cell = (MoreMyPagePasswordChangeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPagePasswordChangeCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
}

@end

#pragma mark 태아정보 변경 모댈
@implementation MoreMyPageFetusChangeModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayList.count + 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreMyPageFetusHeaderCell = @"MoreMyPageFetusHeaderCell";
    static NSString *CellIdentifierMoreMyPageFetusContentsCell = @"MoreMyPageFetusContentsCell";
    
    UINib *reuseMoreMyPageFetusHeaderCell = [UINib nibWithNibName:@"MoreMyPageFetusHeaderCell" bundle:nil];
    [tableView registerNib:reuseMoreMyPageFetusHeaderCell forCellReuseIdentifier:CellIdentifierMoreMyPageFetusHeaderCell];
    
    UINib *reuseMoreMyPageFetusContentsCell = [UINib nibWithNibName:@"MoreMyPageFetusContentsCell" bundle:nil];
    [tableView registerNib:reuseMoreMyPageFetusContentsCell forCellReuseIdentifier:CellIdentifierMoreMyPageFetusContentsCell];
    
    if (indexPath.row == 0) {
        
        MoreMyPageFetusHeaderCell *cell = (MoreMyPageFetusHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageFetusHeaderCell];
        
        if (cell == nil) {
            
            cell = (MoreMyPageFetusHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageFetusHeaderCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.txtFetusCount.text = [NSString stringWithFormat:@"%lu명", (unsigned long)[_arrayList count]];
        
        return cell;
    }
    else {
        
        MoreMyPageFetusContentsCell *cell = (MoreMyPageFetusContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageFetusContentsCell];
        
        if (cell == nil) {
            
            cell = (MoreMyPageFetusContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageFetusContentsCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if([cell.txtFetusName.text isEqualToString:@""]){
            cell.txtFetusName.text = [[_arrayList objectAtIndex:indexPath.row-1] objectForKey:@"baby_nickname"];
        }
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 헤더셀
    if (indexPath.row == 0) {
        return 70;
    }
    // 컨텐츠 셀
    else {
        return 46;
    }
}

-(void)deleteBabyNicknameButton:(id)sender{
    [_delegate deleteBabyNicknameButton:sender];
}

-(void)changeCell:(NSInteger)count{
    [_delegate changeCell:count];
}

@end

#pragma mark 포인트
@implementation MoreMyPagePointModel

- (id) init {
    
    if (self = [super init]) {
        
        _arrayList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMorePointCell = @"MorePointCell";
    
    UINib *reuseMorePointCell;
    
    if (tableView.frame.size.width <= 320) {
        
        reuseMorePointCell = [UINib nibWithNibName:@"MorePointCell_320" bundle:nil];
    }
    else if (tableView.frame.size.width <= 375) {
        
        reuseMorePointCell = [UINib nibWithNibName:@"MorePointCell_375" bundle:nil];
    }
    else {
        
        reuseMorePointCell = [UINib nibWithNibName:@"MorePointCell_414" bundle:nil];
    }
    
    [tableView registerNib:reuseMorePointCell forCellReuseIdentifier:CellIdentifierMorePointCell];
    
    MorePointCell *cell = (MorePointCell *)[tableView dequeueReusableCellWithIdentifier:@"MorePointCell"];
    
    if (cell == nil) {
        
        cell = (MorePointCell *)[tableView dequeueReusableCellWithIdentifier:@"MorePointCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = _arrayList[indexPath.row];
    
    cell.lblPoint.text = [NSString stringWithFormat:@"%d", [dic[@"amount"] intValue]];
    cell.lblType.text = dic[@"name"];
    cell.lblAcquisitionDay.text = [NSString stringWithFormat:@"획득일 %@", [[MommyUtils sharedGlobalData] getMommyDateyyyyMMdd:dic[@"reg_dttm"]]];
    
    if (indexPath.row == _arrayList.count - 1 && _arrayList.count % 30 == 0) {
        
        if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
            
            [self.delegate tableView:tableView totalPageCount:_arrayList.count];
        }
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 79;
}

@end

























