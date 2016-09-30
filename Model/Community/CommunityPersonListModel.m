//
//  CommunityPersonListModel.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityPersonListModel.h"
#define PERSON_CELL_ID @"PERSON_CELL_ID"

@implementation CommunityPersonListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _personList = [[NSMutableArray alloc]init];
        
        [_personList addObject:@""];
        [_personList addObject:@""];
        [_personList addObject:@""];
        [_personList addObject:@""];
        [_personList addObject:@""];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_personList count];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityPersonListCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:PERSON_CELL_ID];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"CommunityPersonListCustomCell" bundle:nil] forCellReuseIdentifier:PERSON_CELL_ID];
        
        cell = [tableView dequeueReusableCellWithIdentifier:PERSON_CELL_ID];
    }
    
    if(_addMentorButtonFlag == NO){
        cell.addButton.hidden = YES;
        cell.addLabel.hidden = YES;
    }
    //      cell.delegate = self;
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
    int height = 70;
    
    return height;
}

@end
