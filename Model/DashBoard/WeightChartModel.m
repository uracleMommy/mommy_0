//
//  WeightChartModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightChartModel.h"
#import "WeightChartViewCell.h"
#import "WeightDetailInfoHeaderCell.h"
#import "WeightDetailInfoContentsCell.h"
#import "WeightDetailInfoFooterCell.h"

@implementation WeightChartModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_arrayList.count > 0) {
        
        // 차트 셀 한개는 리턴이 되어야 함
        return _arrayList.count + 1;
    }
    else {
        
        // 차트셀 + 인포셀 헤더 풋터
        return _arrayList.count + 3;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMessageListCell = @"WeightChartViewCell";
    static NSString *CellIdentifierWeightDetailInfoHeaderCell = @"WeightDetailInfoHeaderCell";
    static NSString *CellIdentifierWeightDetailInfoContentsCell = @"WeightDetailInfoContentsCell";
    static NSString *CellIdentifierWeightDetailInfoFooterCell = @"WeightDetailInfoFooterCell";
    
    UINib *reuseWeightChartViewCell = [UINib nibWithNibName:@"WeightChartViewCell" bundle:nil];
    [tableView registerNib:reuseWeightChartViewCell forCellReuseIdentifier:CellIdentifierMessageListCell];
    
    UINib *reuseWeightDetailInfoHeaderCell = [UINib nibWithNibName:@"WeightDetailInfoHeaderCell" bundle:nil];
    [tableView registerNib:reuseWeightDetailInfoHeaderCell forCellReuseIdentifier:CellIdentifierWeightDetailInfoHeaderCell];
    
    UINib *reuseWeightDetailInfoContentsCell = [UINib nibWithNibName:@"WeightDetailInfoContentsCell" bundle:nil];
    [tableView registerNib:reuseWeightDetailInfoContentsCell forCellReuseIdentifier:CellIdentifierWeightDetailInfoContentsCell];
    
    UINib *reuseWeightDetailInfoFooterCell = [UINib nibWithNibName:@"WeightDetailInfoFooterCell" bundle:nil];
    [tableView registerNib:reuseWeightDetailInfoFooterCell forCellReuseIdentifier:CellIdentifierWeightDetailInfoFooterCell];
    
    // 데이터가 있을 때(전체 리턴)
    if (_arrayList.count > 0) {
        
        // 웹 차트
        if (indexPath.row == 0) {
            
            WeightChartViewCell *cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMessageListCell];
            
            if (cell == nil) {
                
                cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMessageListCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        // 디테일 정보 헤더
        else if (indexPath.row == 1) {
            
            WeightDetailInfoHeaderCell *cell = (WeightDetailInfoHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoHeaderCell];
            
            if (cell == nil) {
                
                cell = (WeightDetailInfoHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoHeaderCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        // 디테일 정보 풋터
        else if (indexPath.row + 1 == _arrayList.count + 3) {
            
            WeightDetailInfoFooterCell *cell = (WeightDetailInfoFooterCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoFooterCell];
            
            if (cell == nil) {
                
                cell = (WeightDetailInfoFooterCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoFooterCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
        // 디테일 정보 컨텐츠
        else {
            
            WeightDetailInfoContentsCell *cell = (WeightDetailInfoContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoContentsCell];
            
            if (cell == nil) {
                
                cell = (WeightDetailInfoContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoContentsCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
    // 데이터가 없을 때(차트만 리턴)
    else {
        
        WeightChartViewCell *cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMessageListCell];
        
        if (cell == nil) {
            
            cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMessageListCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 데이터가 있을 때(전체 리턴)
    if (_arrayList.count > 0) {
        
        // 차트 높이
        if (indexPath.row == 0) {
            
            return 356.0f;
        }
        // 디테일 정보 헤더 높이
        else if (indexPath.row == 1) {
            
            return 40.0f;
        }
        // 디테일 정보 풋터 높이
        else if (indexPath.row + 1 == _arrayList.count + 3) {
            
            return 28.0f;
        }
        // 디테일 정보 컨텐츠 높이
        else {
            
            return 45.0f;
        }
    }
    // 데이터가 없을 때(차트만 리턴)
    else {
        
        return 356.0f;
    }
}




















@end