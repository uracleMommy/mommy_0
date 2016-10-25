//
//  WeekProgramModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeekProgramModel.h"
#import "WeekProgramCell.h"


@implementation WeekProgramModel

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
    
    static NSString *CellIdentifierWeekProgramCell = @"WeekProgramCell";
    
    UINib *reuseWeekProgramCell = [UINib nibWithNibName:@"WeekProgramCell" bundle:nil];
    [tableView registerNib:reuseWeekProgramCell forCellReuseIdentifier:CellIdentifierWeekProgramCell];
    
    WeekProgramCell *cell = (WeekProgramCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeekProgramCell];
    
    if (cell == nil) {
        
        cell = (WeekProgramCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierWeekProgramCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = _arrayList[indexPath.row];
    
    [NSNull class];
    
    cell.lblWeek.text = dic[@"week"];   // [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
    cell.lblContext.text = [[dic[@"context"] class] isEqual:[NSNull class]] ? @"" : dic[@"context"];
    
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
    CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 134.0, 0);
    
    [firstShapeLayer setPath:firstPath];
    CGPathRelease(firstPath);
    
    [[cell.lblDotLine layer] addSublayer:firstShapeLayer];
    
//    NSString *context = dic[@"context"];
//    NSString *html = dic[@"html"];
//    NSString *img = dic[@"img"];
//    NSString *program_seq = dic[@"program_seq"];
//    NSString *program_title = dic[@"program_title"];
//    NSString *program_type = dic[@"program_type"];
//    NSString *program_type_name = dic[@"program_type_name"];
//    NSString *reg_dttm = dic[@"reg_dttm"];
//    NSString *week = [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
    
    
    if (indexPath.row == _arrayList.count - 1 && _arrayList.count % 30 == 0) {
        
        if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
            
            [self.delegate tableView:tableView totalPageCount:_arrayList.count];
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _arrayList[indexPath.row];
    if(![[dic[@"html"] class] isEqual:[NSNull class]]) {
        
        if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            
            [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

@end
