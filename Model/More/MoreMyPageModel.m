//
//  MoreMyPageModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageModel.h"

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
        
        return cell;
    }
    else {
        
        MoreMyPageFetusContentsCell *cell = (MoreMyPageFetusContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageFetusContentsCell];
        
        if (cell == nil) {
            
            cell = (MoreMyPageFetusContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMyPageFetusContentsCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 헤더셀
    if (indexPath.row == 0) {
        
        return 54;
    }
    // 컨텐츠 셀
    else {
        
        return 40;
    }
}

@end

#pragma mark 포인트
@implementation MoreMyPagePointModel

- (id) init {
    
    if (self = [super init]) {
        
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
    
    return nil;
}

@end

























