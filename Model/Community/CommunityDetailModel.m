//
//  CommunityDetailModel.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityDetailModel.h"
#define CELL0 @"writerInfoCell"
#define CELL1 @"contentCell"
#define CELL2 @"replyPeopleInfoCell"
#define CELL_REPLY @"replyContentCell"

@implementation CommunityDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _detailList = [[NSMutableArray alloc]init];
        
        //기본
        [_detailList addObject:@""];
        [_detailList addObject:@""];
        [_detailList addObject:@""];
        [_detailList addObject:@""];
        [_detailList addObject:@""];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detailList count];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [_delegate tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityDetailCells *cell;
    
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CELL0];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"CommunityDetailWriterInfoCell" bundle:nil] forCellReuseIdentifier:CELL0];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CELL0];
            }
            
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
            
            [[cell.lineLabel layer] addSublayer:firstShapeLayer];
            
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CELL1];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"CommunityDetailContentCell" bundle:nil] forCellReuseIdentifier:CELL1];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CELL1];
            }
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CELL2];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"CommunityDetailReplyPeopleInfoCell" bundle:nil] forCellReuseIdentifier:CELL2];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CELL2];
            }
            break;
        }
        default:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CELL_REPLY];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"CommunityDetailReplyContentCell" bundle:nil] forCellReuseIdentifier:CELL_REPLY];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CELL_REPLY];
            }
            break;
        }
    }
    
    cell.delegate = self;
//    CAShapeLayer *firstShapeLayer = [CAShapeLayer layer];
//    [firstShapeLayer setBounds:cell.bounds];
//    [firstShapeLayer setPosition:cell.center];
//    [firstShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
//    [firstShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
//    [firstShapeLayer setLineWidth:1.0f];
//    [firstShapeLayer setLineJoin:kCALineJoinRound];
//    [firstShapeLayer setLineDashPattern:
//     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
//      [NSNumber numberWithInt:3],nil]];
//    
//    CGMutablePathRef firstPath = CGPathCreateMutable();
//    CGPathMoveToPoint(firstPath, NULL, 0, 0);
//    CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 38.0, 0);
//    
//    [firstShapeLayer setPath:firstPath];
//    CGPathRelease(firstPath);
//    
//    [[cell.writerInfoView layer] addSublayer:firstShapeLayer];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (indexPath.row) {
        case 0:
            height = 73;
          break;
        case 1:
            height = 219;
            break;
        case 2:
            height = 60;
            break;
        default:
            height = 85;
            break;
    }
    return height;
}

-(void) moreButtonAction:(id)sender point:(CGPoint)point{
     [_delegate moreButtonAction:sender point:point];   
}

-(void) showProfilePopupViewAction:(id)sender{
    [_delegate showProfilePopupViewAction:sender];
}

@end
