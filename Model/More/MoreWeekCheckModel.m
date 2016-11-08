//
//  MoreWeekCheckModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreWeekCheckModel.h"
#import "MoreWeekCheckCategoryCell.h"
#import "MoreWeekCheckInfoCell.h"

@implementation MoreWeekCheckModel

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
    
//    // 헤더
//    if (section == 0 || section == 2 || section == 4) {
//        
//        return 1;
//    }
//    // 데이터
//    else {
//        
//        NSArray *arrayData = [_arrayList objectAtIndex:section];
//        return arrayData.count;
//    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreWeekCheckInfoCell = @"MoreWeekCheckInfoCell";
    
    UINib *reuseMoreWeekCheckInfoCell = [UINib nibWithNibName:@"MoreWeekCheckInfoCell" bundle:nil];
    [tableView registerNib:reuseMoreWeekCheckInfoCell forCellReuseIdentifier:CellIdentifierMoreWeekCheckInfoCell];
    
    MoreWeekCheckInfoCell *cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];

    if (cell == nil) {

        cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
    }

    NSDictionary *dic = _arrayList[indexPath.row];

    
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
    cell.lblContent.text = dic[@"content"];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UILabel *gettingSizeLabel = [[UILabel alloc] init];
    gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maximumLabelSize = CGSizeMake(310, CGFLOAT_MAX);
    
    CGRect textRect = [cell.lblContent.text boundingRectWithSize:maximumLabelSize
                                                              options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                           attributes:@{NSFontAttributeName:cell.lblContent.font}
                                                              context:nil];
    
    cell.contentsHeightConstraint.constant = textRect.size.height;
    
    return cell;
    
    
    // 컨텐츠가 없어서 섹션 없앰
    
//    static NSString *CellIdentifierMoreWeekCheckCategoryCell = @"MoreWeekCheckCategoryCell";
//    static NSString *CellIdentifierMoreWeekCheckInfoCell = @"MoreWeekCheckInfoCell";
//    
//    
//    UINib *reuseMoreWeekCheckCategoryCell = [UINib nibWithNibName:@"MoreWeekCheckCategoryCell" bundle:nil];
//    [tableView registerNib:reuseMoreWeekCheckCategoryCell forCellReuseIdentifier:CellIdentifierMoreWeekCheckCategoryCell];
//    
//    UINib *reuseMoreWeekCheckInfoCell = [UINib nibWithNibName:@"MoreWeekCheckInfoCell" bundle:nil];
//    [tableView registerNib:reuseMoreWeekCheckInfoCell forCellReuseIdentifier:CellIdentifierMoreWeekCheckInfoCell];
//    
//    // 임신 초기
//    if (indexPath.section == 0) {
//        
//        MoreWeekCheckCategoryCell *cell = (MoreWeekCheckCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckCategoryCell"];
//        
//        if (cell == nil) {
//            
//            cell = (MoreWeekCheckCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckCategoryCell"];
//        }
//        
//        cell.lblTitle.text = @"임신 초기";
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//        
//    }
//    // 임심 초기 데이터
//    else if (indexPath.section == 1) {
//        
//        MoreWeekCheckInfoCell *cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
//        
//        if (cell == nil) {
//            
//            cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
//        }
//        
//        NSDictionary *dic = _arrayList[indexPath.section][indexPath.row];
//        
//        cell.lblTitle.text = dic[@"title"];
//        cell.lblContent.text = dic[@"content"];
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//        
//    }
//    // 임신 중기
//    else if (indexPath.section == 2) {
//        
//        MoreWeekCheckCategoryCell *cell = (MoreWeekCheckCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckCategoryCell"];
//        
//        if (cell == nil) {
//            
//            cell = (MoreWeekCheckCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckCategoryCell"];
//        }
//        
//        cell.lblTitle.text = @"임신 중기";
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
//    // 임신 중기 데이터
//    else if (indexPath.section == 3) {
//        
//        MoreWeekCheckInfoCell *cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
//        
//        if (cell == nil) {
//            
//            cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
//        }
//        
//        NSDictionary *dic = _arrayList[indexPath.section][indexPath.row];
//        
//        cell.lblTitle.text = dic[@"title"];
//        cell.lblContent.text = dic[@"content"];
//    
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
//    // 임신 말기
//    else if (indexPath.section == 4) {
//        
//        MoreWeekCheckCategoryCell *cell = (MoreWeekCheckCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckCategoryCell"];
//        
//        if (cell == nil) {
//            
//            cell = (MoreWeekCheckCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckCategoryCell"];
//        }
//        
//        cell.lblTitle.text = @"임신 말기";
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
//    // 임신 말기 데이터
//    else {
//        
//        MoreWeekCheckInfoCell *cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
//        
//        if (cell == nil) {
//            
//            cell = (MoreWeekCheckInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"MoreWeekCheckInfoCell"];
//        }
//        
//        NSDictionary *dic = _arrayList[indexPath.section][indexPath.row];
//        
//        cell.lblTitle.text = dic[@"title"];
//        cell.lblContent.text = dic[@"content"];
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
    
//    if (indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 4) {
//        
//        return 36;
//    }
//    else {
//        
//        return 70;
//    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:selectedRowIndex:)]) {
        
        [self.delegate tableView:tableView selectedRowIndex:indexPath.row];
    }
}


@end
