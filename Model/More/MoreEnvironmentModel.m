//
//  MoreEnvironmentModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEnvironmentModel.h"

#pragma mark 환경설정 모델
@implementation MoreEnvironmentListModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreEnvironmentMyPageCell = @"MoreEnvironmentMyPageCell";
    static NSString *CellIdentifierMoreEnvironmentAlramCell = @"MoreEnvironmentAlramCell";
    static NSString *CellIdentifierMoreEnvironmentCalendarCell = @"MoreEnvironmentCalendarCell";
    static NSString *CellIdentifierMoreEnvironmentAgreementCell = @"MoreEnvironmentAgreementCell";
    static NSString *CellIdentifierMoreEnvironmentVersionInfoCell = @"MoreEnvironmentVersionInfoCell";
    
    UINib *reuseMoreEnvironmentMyPageCell = [UINib nibWithNibName:@"MoreEnvironmentMyPageCell" bundle:nil];
    [tableView registerNib:reuseMoreEnvironmentMyPageCell forCellReuseIdentifier:CellIdentifierMoreEnvironmentMyPageCell];
    
    UINib *reuseMoreEnvironmentAlramCell = [UINib nibWithNibName:@"MoreEnvironmentAlramCell" bundle:nil];
    [tableView registerNib:reuseMoreEnvironmentAlramCell forCellReuseIdentifier:CellIdentifierMoreEnvironmentAlramCell];
    
    UINib *reuseMoreEnvironmentCalendarCell = [UINib nibWithNibName:@"MoreEnvironmentCalendarCell" bundle:nil];
    [tableView registerNib:reuseMoreEnvironmentCalendarCell forCellReuseIdentifier:CellIdentifierMoreEnvironmentCalendarCell];
    
    UINib *reuseMoreEnvironmentAgreementCell = [UINib nibWithNibName:@"MoreEnvironmentAgreementCell" bundle:nil];
    [tableView registerNib:reuseMoreEnvironmentAgreementCell forCellReuseIdentifier:CellIdentifierMoreEnvironmentAgreementCell];
    
    UINib *reuseMoreEnvironmentVersionInfoCell = [UINib nibWithNibName:@"MoreEnvironmentVersionInfoCell" bundle:nil];
    [tableView registerNib:reuseMoreEnvironmentVersionInfoCell forCellReuseIdentifier:CellIdentifierMoreEnvironmentVersionInfoCell];
    
    if (indexPath.row == 0) {
        
        MoreEnvironmentMyPageCell *cell =   (MoreEnvironmentMyPageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentMyPageCell];
        
        if (cell == nil) {
            
            cell = (MoreEnvironmentMyPageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentMyPageCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row == 1) {
        
        MoreEnvironmentAlramCell *cell = (MoreEnvironmentAlramCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentAlramCell];
        
        if (cell == nil) {
            
            cell = (MoreEnvironmentAlramCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentAlramCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row == 2) {
        
        MoreEnvironmentCalendarCell *cell = (MoreEnvironmentCalendarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentCalendarCell];
        
        if (cell == nil) {
            
            cell = (MoreEnvironmentCalendarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentCalendarCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (indexPath.row == 3) {
        
        MoreEnvironmentAgreementCell *cell = (MoreEnvironmentAgreementCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentAgreementCell];
        
        if (cell == nil) {
            
            cell = (MoreEnvironmentAgreementCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentAgreementCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else {
        
        MoreEnvironmentVersionInfoCell *cell = (MoreEnvironmentVersionInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentVersionInfoCell];
        
        if (cell == nil) {
            
            cell = (MoreEnvironmentVersionInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentVersionInfoCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 버전 정보 가져오기
        NSDictionary *app_info = [[NSBundle mainBundle] infoDictionary];
        NSString *major_version = [app_info objectForKey:@"CFBundleShortVersionString"];
        cell.lblVersion.text = major_version;
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:MoreMyPageModelSelectedIndexPath:)]) {
        
        [self.delegate tableView:tableView MoreMyPageModelSelectedIndexPath:indexPath];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

@end

#pragma mark 캘린더 연결 모델
@implementation MoreEnvironmentCalendarModal

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
    
    static NSString *CellIdentifierMoreEnvironmentCalendarListCell = @"MoreEnvironmentCalendarListCell";
    UINib *reuseCellIdentifierMoreEnvironmentCalendarListCell = [UINib nibWithNibName:@"MoreEnvironmentCalendarListCell" bundle:nil];
    [tableView registerNib:reuseCellIdentifierMoreEnvironmentCalendarListCell forCellReuseIdentifier:CellIdentifierMoreEnvironmentCalendarListCell];
    MoreEnvironmentCalendarListCell *cell = (MoreEnvironmentCalendarListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentCalendarListCell];
    
    if (cell == nil) {
        
        cell = (MoreEnvironmentCalendarListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEnvironmentCalendarListCell];
    }
    
    if (indexPath.row == 0) {
        if(_authFlag){
            [cell.authButton setTitle:@"연결해지" forState:UIControlStateNormal];
//            cell.authButton.titleLabel.text = @"연결해지";
            cell.accountLabel.text = _accountText;
        }else{
            [cell.authButton setTitle:@"연결하기" forState:UIControlStateNormal];
//            cell.authButton.titleLabel.text = @"연결하기";
            cell.accountLabel.text = @"www.google.com";
        }
        cell.calendarImageView.image = [UIImage imageNamed:@"contents_cal_google_n"];
        cell.lblCalendarInfo.text = @"구글 캘린더";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    else {
        
        cell.calendarImageView.image = [UIImage imageNamed:@"contents_cal_naver_n"];
        cell.lblCalendarInfo.text = @"네이버 캘린더";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

-(void)googleAuthLinkAction{
    [_delegate googleAuthLinkAction];
}

@end
















