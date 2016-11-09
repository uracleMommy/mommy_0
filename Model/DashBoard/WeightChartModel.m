//
//  WeightChartModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightChartModel.h"

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
    
    // 데이터가 없을시에 차트만 리턴
    if (_arrayList.count == 0) {
        
        return 1;
    }
    // 데이터 있으면 차트 헤더 푸터 전부 리턴
    else {
        
        return _arrayList.count + 3;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifierWeightChartViewCell = @"WeightChartViewCell";
    static NSString *CellIdentifierWeightDetailInfoHeaderCell = @"WeightDetailInfoHeaderCell";
    static NSString *CellIdentifierWeightDetailInfoContentsCell = @"WeightDetailInfoContentsCell";
    static NSString *CellIdentifierWeightDetailInfoFooterCell = @"WeightDetailInfoFooterCell";
    
    UINib *reuseWeightChartViewCell = [UINib nibWithNibName:@"WeightChartViewCell" bundle:nil];
    [tableView registerNib:reuseWeightChartViewCell forCellReuseIdentifier:CellIdentifierWeightChartViewCell];
    
    UINib *reuseWeightDetailInfoHeaderCell = [UINib nibWithNibName:@"WeightDetailInfoHeaderCell" bundle:nil];
    [tableView registerNib:reuseWeightDetailInfoHeaderCell forCellReuseIdentifier:CellIdentifierWeightDetailInfoHeaderCell];
    
    UINib *reuseWeightDetailInfoContentsCell = [UINib nibWithNibName:@"WeightDetailInfoContentsCell" bundle:nil];
    [tableView registerNib:reuseWeightDetailInfoContentsCell forCellReuseIdentifier:CellIdentifierWeightDetailInfoContentsCell];
    
    UINib *reuseWeightDetailInfoFooterCell = [UINib nibWithNibName:@"WeightDetailInfoFooterCell" bundle:nil];
    [tableView registerNib:reuseWeightDetailInfoFooterCell forCellReuseIdentifier:CellIdentifierWeightDetailInfoFooterCell];
    
    // 헤더
    if (indexPath.row == 0) {
        
        WeightChartViewCell *cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightChartViewCell];
        
        if (cell == nil) {
            
            cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightChartViewCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:_dicList options:0 error:&error];
        NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
        NSLog(@"%@",myString);
        
        
        NSArray *arrString= [[NSString stringWithFormat:@"%@", _dicList[@"rec_weight"]] componentsSeparatedByString: @"~"];

        // 자바스크립트 펑션 호출
        cell.isFirst = YES;
        cell.functionJson = myString;
        cell.lblTitle.text = _dicList[@"title_tag"];
        cell.lblComment.text = [[_dicList[@"comment"] class] isEqual:[NSNull class]] ? @"" : _dicList[@"comment"];
        cell.lblRFirstRangeWeight.text = [[_dicList[@"rec_weight"] class] isEqual:[NSNull class]] ? @"" : [arrString objectAtIndex:0]; //권장체중 first
        cell.lblSecondRangeWeight.text = [[_dicList[@"rec_weight"] class] isEqual:[NSNull class]] ? @"" : [arrString objectAtIndex:1];
        cell.lblWeight.text = [[_dicList[@"weight"] class] isEqual:[NSNull class]] ? @"" : [NSString stringWithFormat:@"%@", _dicList[@"weight"]];//현재체중
        cell.lblWeightAppraisal.text = [[_dicList[@"result"] class] isEqual:[NSNull class]] ? @"" : _dicList[@"result"]; //상태
        
        [cell.webView loadRequest:_chartRequest];
        
        return cell;
    }
    // 컨텐츠 헤더
    else if(indexPath.row == 1) {
        
        WeightDetailInfoHeaderCell *cell = (WeightDetailInfoHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoHeaderCell];
        
        if (cell == nil) {
            
            cell = (WeightDetailInfoHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoHeaderCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    // 컨텐츠 푸터
    else if(indexPath.row == _arrayList.count + 2) {
        
        WeightDetailInfoFooterCell *cell = (WeightDetailInfoFooterCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoFooterCell];
        
        if (cell == nil) {
            
            cell = (WeightDetailInfoFooterCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoFooterCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else {
        
        WeightDetailInfoContentsCell *cell = (WeightDetailInfoContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoContentsCell];
        
        if (cell == nil) {
            
            cell = (WeightDetailInfoContentsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeightDetailInfoContentsCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *dic = _arrayList[indexPath.row - 2];
        
        if (_chartKind == WeightChartDaily) {
            
            cell.lblDate.text = dic[@"reg_dttm"];
        }
        else {
            
            cell.lblDate.text = [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
        }
        
        cell.lblWeight.text = dic[@"weight"];
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 헤더
    if (indexPath.row == 0) {
        
        return 365.0f;
    }
    // 컨텐츠 헤더
    else if(indexPath.row == 1) {
        
        return 43.0f;
    }
    // 컨텐츠 푸터
    else if(indexPath.row == _arrayList.count + 2) {
        
        return 14.0f;
    }
    else {
        
        return 38.0f;
    }
}


#pragma 차트 콜백
- (void) goPrevious {
    
    if ([self.delegate respondsToSelector:@selector(goChartPrevious)]) {
        
        [self.delegate goChartPrevious];
    }
    
}

#pragma 차트 콜백
- (void) goNext {
    
    if ([self.delegate respondsToSelector:@selector(goChartNext)]) {
        
        [self.delegate goChartNext];
    }
}


@end
