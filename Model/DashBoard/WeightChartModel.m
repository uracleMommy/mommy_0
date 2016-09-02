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
    
    return _arrayList.count;
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
    
    // 웹 차트
    if (indexPath.row == 0) {
        
        WeightChartViewCell *cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMessageListCell];
        
        if (cell == nil) {
            
            cell = (WeightChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMessageListCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    // 
    
    return nil;
}

@end