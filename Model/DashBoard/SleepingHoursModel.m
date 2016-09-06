//
//  SleepingHoursModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SleepingHoursModel.h"
#import "SleepingHoursChartViewCell.h"
#import "SleepingHoursEvalCell.h"
#import "SleepingHoursInfoCell.h"

@implementation SleepingHoursModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierSleepingHoursChartViewCell = @"SleepingHoursChartViewCell";
    static NSString *CellIdentifierSleepingHoursEvalCell = @"SleepingHoursEvalCell";
    static NSString *CellIdentifierSleepingHoursInfoCell = @"SleepingHoursInfoCell";
    
    UINib *reuseSleepingHoursChartViewCell = [UINib nibWithNibName:@"SleepingHoursChartViewCell" bundle:nil];
    [tableView registerNib:reuseSleepingHoursChartViewCell forCellReuseIdentifier:CellIdentifierSleepingHoursChartViewCell];
    
    UINib *reuseSleepingHoursEvalCell = [UINib nibWithNibName:@"SleepingHoursEvalCell" bundle:nil];
    [tableView registerNib:reuseSleepingHoursEvalCell forCellReuseIdentifier:CellIdentifierSleepingHoursEvalCell];
    
    UINib *reuseSleepingHoursInfoCell = [UINib nibWithNibName:@"SleepingHoursInfoCell" bundle:nil];
    [tableView registerNib:reuseSleepingHoursInfoCell forCellReuseIdentifier:CellIdentifierSleepingHoursInfoCell];
    
    if (indexPath.row == 0) {
        
        SleepingHoursChartViewCell *cell  = (SleepingHoursChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierSleepingHoursChartViewCell];
        
        if (cell == nil) {
            
            cell  = (SleepingHoursChartViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierSleepingHoursChartViewCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        CAShapeLayer *ShapeLayer = [CAShapeLayer layer];
        [ShapeLayer setBounds:cell.bounds];
        [ShapeLayer setPosition:cell.center];
        [ShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [ShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
        [ShapeLayer setLineWidth:1.0f];
        [ShapeLayer setLineJoin:kCALineJoinRound];
        [ShapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
          [NSNumber numberWithInt:3],nil]];
        
        CGMutablePathRef Path = CGPathCreateMutable();
        CGPathMoveToPoint(Path, NULL, 0, 0);
        CGPathAddLineToPoint(Path, NULL, tableView.frame.size.width - 32.0, 0);
        
        [ShapeLayer setPath:Path];
        CGPathRelease(Path);
        
        [[cell.lblDotLine layer] addSublayer:ShapeLayer];
        
        return cell;
    }
    else if (indexPath.row == 1) {
        
        SleepingHoursEvalCell *cell = (SleepingHoursEvalCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierSleepingHoursEvalCell];
        
        if (cell == nil) {
            
            cell = (SleepingHoursEvalCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierSleepingHoursEvalCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else {
        
        SleepingHoursInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierSleepingHoursInfoCell];
        
        if (cell == nil) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierSleepingHoursInfoCell];
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
        
        [[cell.firstLblFirstDotLine layer] addSublayer:firstShapeLayer];
        
        
        
        CAShapeLayer *secnodShapeLayer = [CAShapeLayer layer];
        [secnodShapeLayer setBounds:cell.bounds];
        [secnodShapeLayer setPosition:cell.center];
        [secnodShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [secnodShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
        [secnodShapeLayer setLineWidth:1.0f];
        [secnodShapeLayer setLineJoin:kCALineJoinRound];
        [secnodShapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
          [NSNumber numberWithInt:3],nil]];
        
        CGMutablePathRef secondPath = CGPathCreateMutable();
        CGPathMoveToPoint(secondPath, NULL, 0, 0);
        CGPathAddLineToPoint(secondPath, NULL, tableView.frame.size.width - 38.0, 0);
        
        [secnodShapeLayer setPath:secondPath];
        CGPathRelease(secondPath);
        
        [[cell.secondLblFirstDotLine layer] addSublayer:secnodShapeLayer];
        
        
        CAShapeLayer *thirdShapeLayer = [CAShapeLayer layer];
        [thirdShapeLayer setBounds:cell.bounds];
        [thirdShapeLayer setPosition:cell.center];
        [thirdShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [thirdShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
        [thirdShapeLayer setLineWidth:1.0f];
        [thirdShapeLayer setLineJoin:kCALineJoinRound];
        [thirdShapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
          [NSNumber numberWithInt:3],nil]];
        
        CGMutablePathRef thirdPath = CGPathCreateMutable();
        CGPathMoveToPoint(thirdPath, NULL, 0, 0);
        CGPathAddLineToPoint(thirdPath, NULL, tableView.frame.size.width - 38.0, 0);
        
        [thirdShapeLayer setPath:thirdPath];
        CGPathRelease(thirdPath);
        
        [[cell.thirdLblFirstDotLine layer] addSublayer:thirdShapeLayer];
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 314;
    }
    else if (indexPath.row == 1) {
        
        return 70;
    }
    else {
        
        return 280;
    }
    
    return 0;
}

@end
