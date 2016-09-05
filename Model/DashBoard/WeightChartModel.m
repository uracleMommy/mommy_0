//
//  WeightChartModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightChartModel.h"
#import "WeightChartViewCell.h"
#import "WeightTotalInfoCell.h"
#import "WeightInfoView.h"

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
        
        // 차트셀 + 인포셀 헤더 풋터
        return 2;
    }
    else {
        
        // 차트 셀 한개는 리턴이 되어야 함
        return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifierWeightChartViewCell = @"WeightChartViewCell";
    static NSString *CellIdentifierWeightTotalInfoCell = @"WeightTotalInfoCell";
    
    UINib *reuseWeightChartViewCell = [UINib nibWithNibName:@"WeightChartViewCell" bundle:nil];
    [tableView registerNib:reuseWeightChartViewCell forCellReuseIdentifier:CellIdentifierWeightChartViewCell];
    
    UINib *reuseWeightTotalInfoCell = [UINib nibWithNibName:@"WeightTotalInfoCell" bundle:nil];;
    [tableView registerNib:reuseWeightTotalInfoCell forCellReuseIdentifier:CellIdentifierWeightTotalInfoCell];
    
    // 데이터가 있을시에(차트와 데이터 리턴)
    if (_arrayList > 0) {
        
        if (indexPath.row == 0) {
            
            WeightChartViewCell *cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightChartViewCell];
            
            if (cell == nil) {
                
                cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightChartViewCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else {
            
            WeightTotalInfoCell *cell = (WeightTotalInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightTotalInfoCell];
            
            if (cell == nil) {
                
                cell = (WeightTotalInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightTotalInfoCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        
            NSLog(@"%f", cell.containerView.frame.size.width);
            
            // 여기서 셀 컨네이너 뷰에 뷰 추가
            
            for (int i = 0; i<_arrayList.count; i++) {
                
                float viewYPosition = i * 40.5;
                WeightInfoView *weightInfoView = [[WeightInfoView alloc] initWithNibName:@"WeightInfoView" bundle:nil];
                [weightInfoView.view setFrame:CGRectMake(0, viewYPosition, tableView.frame.size.width - 32, 40.5f)];
                
                //  컨테이너뷰 사이즈 조절
                [cell.containerView setFrame:CGRectMake(8, 8, tableView.frame.size.width - 16, 100 + 40.5f * i)];
                
//                [cell.infoViewContainer setFrame:CGRectMake(0, 38, tableView.frame.size.width - 16, 36 * i + 1)];
                [cell.infoViewContainer addSubview:weightInfoView.view];
            }
            
            return cell;            
        }
    }
    // 데이터가 없을시에(차트와 데이터가 없습니다 리턴)
    else {
        
        WeightChartViewCell *cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightChartViewCell];
        
        if (cell == nil) {
            
            cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightChartViewCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"인덱스 로우 : %ld", (long)indexPath.row);
    
    // 데이터가 있을 때(전체 리턴)
    if (_arrayList.count > 0) {
        
        // 차트 높이
        if (indexPath.row == 0) {
            
            return 365.0f;
        }
        else {
//            NSLog(@"%f", 90.0f + indexPath.row * 36.0f);
            return 113.0f + (_arrayList.count - 1) * 40.5f;
        }
    }
    // 데이터가 없을 때(차트만 리턴)
    else {
        
        return 365.0f;
    }
}

@end