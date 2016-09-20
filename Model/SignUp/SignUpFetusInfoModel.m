//
//  SignUpFetusInfoModel.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpFetusInfoModel.h"
#define BASIC_CELL_ID @"BASIC_CELL_ID"
#define PLUS_CELL_ID @"PLUS_CELL_ID"

@implementation SignUpFetusInfoModel
@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fetusNames = [[NSMutableArray alloc]init];
        
        [_fetusNames addObject:@""];
        
    }
        return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetusNames count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath indexAtPosition: 1] < [_fetusNames count]){
        SignUpFetusInfoCustomCell_Basic *cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        
        if(cell == nil){
            [tableView registerNib:[UINib nibWithNibName:@"SignUpFetusInfoCustomCell_Basic" bundle:nil] forCellReuseIdentifier:BASIC_CELL_ID];
            
            cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        }
        cell.delegate = self;
        return cell;
        
        
    }else{
        SignUpFetusInfoCustomCell_Plus *cell = [tableView dequeueReusableCellWithIdentifier:PLUS_CELL_ID];
        
        if(cell == nil){
            [tableView registerNib:[UINib nibWithNibName:@"SignUpFetusInfoCustomCell_Plus" bundle:nil] forCellReuseIdentifier:PLUS_CELL_ID];
            
            cell = [tableView dequeueReusableCellWithIdentifier:PLUS_CELL_ID];
        }
        cell.delegate = self;
        return cell;
    }
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 45;
    int row = (int)[indexPath row];
    int maxrow = (int)[_fetusNames count];
    
    if(row == maxrow){
        height = height+45;
    }
    
    return height;
}

-(void)addTableCell{
    NSLog(@"PSH addTableCell");
    if([_fetusNames count] <= 4){
        [delegate addTableCell];
    }
}

-(void)deleteTableCell:(id)sender{
    NSLog(@"PSH deleteTableCell");
    [delegate deleteTableCell:sender];
}

@end
