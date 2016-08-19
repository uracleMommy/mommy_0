//
//  DiaryListModel.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListModel.h"
#define BASIC_CELL_ID @"BASIC_CELL_ID"
#define IMAGE_CELL_ID @"IMAGE_CELL_ID"

@implementation DiaryListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _diaryList = [[NSMutableArray alloc]init];
        
        [_diaryList addObject:@""];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_diaryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if([indexPath indexAtPosition: 1] < [_diaryList count]){
        DiaryListBasicCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        
        if(cell == nil){
            [tableView registerNib:[UINib nibWithNibName:@"DiaryListBasicCustomCell" bundle:nil] forCellReuseIdentifier:BASIC_CELL_ID];
            
            cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        }
//        cell.delegate = self;
        return cell;
        
        
//    }else{
//        DiaryListImageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];
//        
//        if(cell == nil){
//            [tableView registerNib:[UINib nibWithNibName:@"DiaryListImageCustomCell" bundle:nil] forCellReuseIdentifier:IMAGE_CELL_ID];
//            
//            cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];
//        }
////        cell.delegate = self;
//        return cell;
//    }
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
    int height = 106;
    
    return height;
}
@end
