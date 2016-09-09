//
//  MoreBloodPressureModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureModel.h"
#import "MoreBloodPressureChartCell.h"
#import "MoreBloodPressureHistoryCell.h"
#import "MoreBloodPressureInfoView.h"

@implementation MoreBloodPressureModel

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
    
    static NSString *CellIdentifierMoreBloodPressureChartCell = @"MoreBloodPressureChartCell";
    static NSString *CellIdentifierMoreBloodPressureHistoryCell = @"MoreBloodPressureHistoryCell";
    
    UINib *reuseMoreBloodPressureChartCell = [UINib nibWithNibName:@"MoreBloodPressureChartCell" bundle:nil];
    [tableView registerNib:reuseMoreBloodPressureChartCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureChartCell];
    
    UINib *reuseMoreBloodPressureHistoryCell = [UINib nibWithNibName:@"MoreBloodPressureHistoryCell" bundle:nil];;
    [tableView registerNib:reuseMoreBloodPressureHistoryCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
    
    if (_arrayList.count > 0) {
        
        if (indexPath.row == 0) {
            
            MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
            
            if (cell == nil) {
                
                cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else {
            
            MoreBloodPressureHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
            
            if (cell == nil) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            for (int i = 0; i < _arrayList.count; i++) {
                
                float viewYPosition = i * 70;
                MoreBloodPressureInfoView *moreBloodPressureInfoView = [[MoreBloodPressureInfoView alloc] initWithNibName:@"MoreBloodPressureInfoView" bundle:nil];
                
                // 컨테이너뷰 사이즈 조절
                [cell.containerView setFrame:CGRectMake(8, 45, tableView.frame.size.width - 16, 124 + (70.0f * i))];
                
                // 인포뷰에 애드
                
                [moreBloodPressureInfoView.view setFrame:CGRectMake(0, viewYPosition, cell.infoViewContainer.frame.size.width, 70.0f)];
                [cell.infoViewContainer addSubview:moreBloodPressureInfoView.view];
                
                NSLog(@"%f", moreBloodPressureInfoView.view.frame.size.width);
            }
            
            return cell;
        }
    }
    else {
        
        MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
        
        if (cell == nil) {
            
            cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
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
            
            return 263.0f;
        }
        else {
            
            return 124.0f + (_arrayList.count - 1) * 70.0f;
        }
    }
    // 데이터가 없을 때(차트만 리턴)
    else {
        
        return 263.0f;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        
//        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
//    }
}

@end
