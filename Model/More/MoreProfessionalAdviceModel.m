//
//  MoreProfessionalAdviceModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalAdviceModel.h"
#import "MoreProfessionalAdviceCell.h"

@implementation MoreProfessionalAdviceModel

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
    
    static NSString *CellIdentifierMoreProfessionalAdviceCell = @"MoreProfessionalAdviceCell";
    
    UINib *reuseMoreProfessionalAdviceCell = [UINib nibWithNibName:@"MoreProfessionalAdviceCell" bundle:nil];
    [tableView registerNib:reuseMoreProfessionalAdviceCell forCellReuseIdentifier:CellIdentifierMoreProfessionalAdviceCell];
    
    MoreProfessionalAdviceCell *cell = (MoreProfessionalAdviceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreProfessionalAdviceCell];
    
    if (cell == nil) {
        
        cell = (MoreProfessionalAdviceCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreProfessionalAdviceCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 38.0, 0);
    
    [firstShapeLayer setPath:firstPath];
    CGPathRelease(firstPath);
    
    [[cell.lblDotLine layer] addSublayer:firstShapeLayer];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:moreProfessionalSelectedIndexPath:)]) {
        
        [self.delegate tableView:tableView moreProfessionalSelectedIndexPath:indexPath];
    }
}

@end
