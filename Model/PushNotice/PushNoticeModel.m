//
//  PushNoticeModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "PushNoticeModel.h"
#import "PushViewListCell.h"
#import "MommyUtils.h"

@implementation PushNoticeModel

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
    
    static NSString *CellIdentifierNoticeCell = @"PushViewListCell";
    
    UINib *reuseCell = [UINib nibWithNibName:@"PushViewListCell" bundle:nil];
    [tableView registerNib:reuseCell forCellReuseIdentifier:CellIdentifierNoticeCell];
    
    PushViewListCell *cell = (PushViewListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    
    if (cell == nil) {
        
        cell = (PushViewListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    }
    
    NSDictionary *dic = _arrayList[indexPath.row];
    
    // 데이터 바인딩
    cell.lblNoticeTime.text = [[MommyUtils sharedGlobalData] getMommyDate:dic[@"reg_dttm"]];
    
    // 체중
    if (![dic[@"type"] isEqual:[NSNull null]] && [dic[@"type"] isEqualToString:@"11"]) {
        
        cell.imgType.image = [UIImage imageNamed:@"contents_icon_alarm01"];
        cell.lblTypeName.text = @"체중";
    }
    // 활동
    else if(![dic[@"type"] isEqual:[NSNull null]] && [dic[@"type"] isEqualToString:@"12"]) {
        
        cell.imgType.image = [UIImage imageNamed:@"contents_icon_alarm02"];
        cell.lblTypeName.text = @"활동";
    }
    // 혈압
    else if(![dic[@"type"] isEqual:[NSNull null]] && [dic[@"type"] isEqualToString:@"13"]) {
        
        cell.imgType.image = [UIImage imageNamed:@"contents_icon_alarm03"];
        cell.lblTypeName.text = @"혈압";
    }
    // 일반
    else {
        
        cell.imgType.image = [UIImage imageNamed:@"contents_icon_alarm04"];
        cell.lblTypeName.text = @"일반";
    }
    
    // 내용
    cell.lblNoticeContent.text = dic[@"content"];
    
    // 점선처리
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:cell.bounds];
    [shapeLayer setPosition:cell.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, tableView.frame.size.width -  78.0, 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[cell.lblDotLine layer] addSublayer:shapeLayer];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 마지막 셀일때 페이지 더보기 로드
    if (indexPath.row == _arrayList.count - 1 && _arrayList.count % 30 == 0) {
        
        if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
            
            [self.delegate tableView:tableView totalPageCount:_arrayList.count];
        }
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 129.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
