//
//  CommunityNewspeedListModel.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityNewspeedListModel.h"
#define BASIC_CELL_ID @"BASIC_CELL_ID"

@implementation CommunityNewspeedListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _newspeedList = [[NSMutableArray alloc]init];
        
        [_newspeedList addObject:@""];
        [_newspeedList addObject:@""];
        [_newspeedList addObject:@""];
        [_newspeedList addObject:@""];
        [_newspeedList addObject:@""];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_newspeedList count];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityNewspeedBasicCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"CommunityNewspeedBasicCustomCell" bundle:nil] forCellReuseIdentifier:BASIC_CELL_ID];
        
        cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
    }
    
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
    
    [[cell.writerInfoView layer] addSublayer:firstShapeLayer];
    
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
    return 202;
}


#pragma marks cell delegate

- (void)moreButtonAction:(id)sender point:(CGPoint)point{
    NSLog(@"moreButton");
    [_delegate moreButtonAction:sender point:point];
}

- (void)moveDetailViewButtonAction:(id)sender{
    NSLog(@"moveDetailViewButtonAction");
    [_delegate moveDetailViewButtonAction:sender];
}

- (void)moveWriteMessageViewAction:(id)sender{
    NSLog(@"moveWriteMessageViewAction");
    [_delegate moveWriteMessageViewAction:sender];
}

- (void)showProfilePopupViewAction:(id)sender{
    [_delegate showProfilePopupViewAction:sender];
}


@end
