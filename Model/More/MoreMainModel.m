//
//  MoreMainModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMainModel.h"
#import "MoreMainTitleCell.h"
#import "MoreMainMenuCell.h"

@interface MoreMainModel ()<MoreMainMenuCellDelegate>

@end

@implementation MoreMainModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreMainTitleCell = @"MoreMainTitleCell";
    static NSString *CellIdentifierMoreMainMenuCell = @"MoreMainMenuCell";
    
    UINib *reuseMoreMainTitleCell = [UINib nibWithNibName:@"MoreMainTitleCell" bundle:nil];
    [tableView registerNib:reuseMoreMainTitleCell forCellReuseIdentifier:CellIdentifierMoreMainTitleCell];
    
    UINib *reuseMoreMainMenuCell = [UINib nibWithNibName:@"MoreMainMenuCell" bundle:nil];
    [tableView registerNib:reuseMoreMainMenuCell forCellReuseIdentifier:CellIdentifierMoreMainMenuCell];
    
    // 타이틀 셀
    if (indexPath.row == 0) {
        
        MoreMainTitleCell *cell = (MoreMainTitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMainTitleCell];
        
        if (cell == nil) {
            cell = (MoreMainTitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMainTitleCell];
        }
        
        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], _arrayList[@"img"]];
        
//        UIImage *profileImg = nil;
        if(_profileImg != nil){
            [cell.imgProfile setImage:_profileImg];
        }else{
            if([_arrayList[@"img"] isEqualToString:@""]){
                _profileImg = [UIImage imageNamed:@"contents_profile_default"];
                [cell.imgProfile setImage:_profileImg];
            }else{
                
                char const * s = [_arrayList[@"img"]  UTF8String];
                dispatch_queue_t queue = dispatch_queue_create(s, 0);
                dispatch_async(queue, ^{
                    
                    NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                    _profileImg = [[UIImage alloc] initWithData:firstImageData];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell.imgProfile setImage:_profileImg];
                    });
                });
                
            }
        }
        
        cell.nameLabel.text = _arrayList[@"name"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    // 메뉴 셀
    else {
        
        MoreMainMenuCell *cell = (MoreMainMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMainMenuCell];
        
        if (cell == nil) {
            
            cell = (MoreMainMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreMainMenuCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
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
        
        [[cell.firstLblDotLine layer] addSublayer:firstShapeLayer];
        
        
        
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
        
        [[cell.secondLblDotLine layer] addSublayer:secnodShapeLayer];
        
        
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
        
        [[cell.thirdLblDotLine layer] addSublayer:thirdShapeLayer];
        
        CAShapeLayer *fourthShapeLayer = [CAShapeLayer layer];
        [fourthShapeLayer setBounds:cell.bounds];
        [fourthShapeLayer setPosition:cell.center];
        [fourthShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [fourthShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
        [fourthShapeLayer setLineWidth:1.0f];
        [fourthShapeLayer setLineJoin:kCALineJoinRound];
        [fourthShapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
          [NSNumber numberWithInt:3],nil]];
        
        CGMutablePathRef fourthPath = CGPathCreateMutable();
        CGPathMoveToPoint(fourthPath, NULL, 0, 0);
        CGPathAddLineToPoint(fourthPath, NULL, tableView.frame.size.width - 38.0, 0);
        
        [fourthShapeLayer setPath:fourthPath];
        CGPathRelease(fourthPath);
        
        [[cell.fourthLblDotLine layer] addSublayer:fourthShapeLayer];
        
        CAShapeLayer *fifthShapeLayer = [CAShapeLayer layer];
        [fifthShapeLayer setBounds:cell.bounds];
        [fifthShapeLayer setPosition:cell.center];
        [fifthShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [fifthShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
        [fifthShapeLayer setLineWidth:1.0f];
        [fifthShapeLayer setLineJoin:kCALineJoinRound];
        [fifthShapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
          [NSNumber numberWithInt:3],nil]];
        
        CGMutablePathRef fifthPath = CGPathCreateMutable();
        CGPathMoveToPoint(fifthPath, NULL, 0, 0);
        CGPathAddLineToPoint(fifthPath, NULL, tableView.frame.size.width - 38.0, 0);
        
        [fifthShapeLayer setPath:fifthPath];
        CGPathRelease(fifthPath);
        
        [[cell.fifthLblDotLine layer] addSublayer:fifthShapeLayer];        
        
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 71;
    }
    
    else {
        
        return 417;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        if ([self.delegate respondsToSelector:@selector(selectedIndexPath:)]) {
            
            [self.delegate selectedIndexPath:indexPath.row];
        }
    }
}

- (void) moreMenuTouchIndex:(NSInteger)index {        
    
    if ([self.delegate respondsToSelector:@selector(selectedIndexPath:)]) {
        
        [self.delegate selectedIndexPath:index];
    }
}



















@end
