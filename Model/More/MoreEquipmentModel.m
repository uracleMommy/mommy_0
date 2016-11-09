//
//  MoreEquipmentModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentModel.h"

#pragma mark 연결된 기기리스트 모델
@implementation MoreEquipmentListModel

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
    
    static NSString *CellIdentifierMoreEquipmentListCell = @"MoreEquipmentListCell";
    
    UINib *reuseMoreEquipmentListCell = [UINib nibWithNibName:@"MoreEquipmentListCell" bundle:nil];
    [tableView registerNib:reuseMoreEquipmentListCell forCellReuseIdentifier:CellIdentifierMoreEquipmentListCell];
    
    MoreEquipmentListCell *cell = (MoreEquipmentListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEquipmentListCell];
    
    if (cell == nil) {
        
        cell = (MoreEquipmentListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEquipmentListCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = _arrayList[indexPath.row];
    cell.lblDeviceName.text = dic[@"deviceName"];
    cell.lblModelName.text = dic[@"modelName"];
    
    CAShapeLayer *firstShapeLayer = [CAShapeLayer layer];
    [firstShapeLayer setBounds:cell.bounds];
    [firstShapeLayer setPosition:cell.center];
    [firstShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [firstShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
    [firstShapeLayer setLineWidth:1.0f];
    [firstShapeLayer setLineJoin:kCALineJoinRound];
    [firstShapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    CGMutablePathRef firstPath = CGPathCreateMutable();
    CGPathMoveToPoint(firstPath, NULL, 0, 0);
    CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 140.0, 0);
    
    [firstShapeLayer setPath:firstPath];
    CGPathRelease(firstPath);
    
    [[cell.lblDotLine layer] addSublayer:firstShapeLayer];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end

#pragma mark 기기선택 모델
@implementation MoreEquipmentChoiceModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //밴드 X
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreEquipmentChoiceCell = @"MoreEquipmentChoiceCell";
    
    UINib *reuseMoreEquipmentChoiceCell = [UINib nibWithNibName:@"MoreEquipmentChoiceCell" bundle:nil];
    [tableView registerNib:reuseMoreEquipmentChoiceCell forCellReuseIdentifier:CellIdentifierMoreEquipmentChoiceCell];
    
    MoreEquipmentChoiceCell *cell = (MoreEquipmentChoiceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEquipmentChoiceCell];
    
    if (cell == nil) {
        
        cell = (MoreEquipmentChoiceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEquipmentChoiceCell];
        
    }
    
    if (indexPath.row == 0) {
        
        cell.lblTitle.text = @"체중계";
        cell.lblModel.text = @"CAS (A2)";
        [cell.deviceImageView setImage:[UIImage imageNamed:@"con_img_cas"]];
    }
    else {
        
        cell.lblTitle.text = @"체중계 이름";
        cell.lblModel.text = @"(모델명)";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:MoreEquipmentChoiceSelectedRow:)]) {
        
        [self.delegate tableView:tableView MoreEquipmentChoiceSelectedRow:indexPath];
    }
}

@end

#pragma mark 기기 검색중 모델
@implementation MoreEquipmentSearchingModel

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
    
    static NSString *CellIdentifierMoreEquipmentChoiceCell = @"MoreEquipmentChoiceCell";
    
    UINib *reuseMoreEquipmentChoiceCell = [UINib nibWithNibName:@"MoreEquipmentChoiceCell" bundle:nil];
    [tableView registerNib:reuseMoreEquipmentChoiceCell forCellReuseIdentifier:CellIdentifierMoreEquipmentChoiceCell];
    
    MoreEquipmentChoiceCell *cell = (MoreEquipmentChoiceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEquipmentChoiceCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

@end

#pragma mark 검색된 기기 선택 모델

@implementation MoreEquipmentSelectModel

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
    
    static NSString *CellIdentifierMoreEquipmentSelectCell = @"MoreEquipmentSelectCell";
    
    UINib *reuseMoreEquipmentSelectCell = [UINib nibWithNibName:@"MoreEquipmentSelectCell" bundle:nil];
    [tableView registerNib:reuseMoreEquipmentSelectCell forCellReuseIdentifier:CellIdentifierMoreEquipmentSelectCell];
    
    MoreEquipmentSelectCell *cell = (MoreEquipmentSelectCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreEquipmentSelectCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:MoreEquipmentChoiceSelectedRow:)]) {
        
        [self.delegate tableView:tableView MoreEquipmentChoiceSelectedRow:indexPath];
    }
}

@end


















