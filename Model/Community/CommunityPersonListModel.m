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
        _cachedImages = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_personList count];
}

- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    [_delegate tableView:tableView totalPageCount:count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityPersonListCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:PERSON_CELL_ID];
    
    NSDictionary *data = [_personList objectAtIndex:[indexPath indexAtPosition:1]];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"CommunityPersonListCustomCell" bundle:nil] forCellReuseIdentifier:PERSON_CELL_ID];
        
        cell = [tableView dequeueReusableCellWithIdentifier:PERSON_CELL_ID];
    }
    
    cell.mentorKey = [data objectForKey:@"mento_key"];
//    cell.mentorId = [data objectForKey:@"mento_id"];
    cell.mentorNicknameLabel.text = [data objectForKey:@"mento_nickname"];
    cell.mentorBirthdayLabel.text = [NSString stringWithFormat:@"%@년생", [[data objectForKey:@"mento_birth"] substringWithRange:NSMakeRange(2, 2)]];
    
    if([[data objectForKey:@"mento_yn"] isEqualToString:@"Y"]){
        [cell.mentorButtonImage setImage:[UIImage imageNamed:@"popup_btn_icon_mentor.png"]];
    }else{
        [cell.mentorButtonImage setImage:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"] ];
    }
    
    if(_addMentorButtonFlag){
        // 이미지 캐시 바인딩
        NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [data objectForKey:@"mento_img"]];
        
        if([[data objectForKey:@"mento_img"] isEqualToString:@""]){
            [cell.mentorImageView setImage:[UIImage imageNamed:@"contents_profile_default"]];
        }else{
            if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                [cell.mentorImageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
            }else {
                char const * s = [profileImageIdentifier  UTF8String];
                dispatch_queue_t queue = dispatch_queue_create(s, 0);
                dispatch_async(queue, ^{
                    
                    NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [data objectForKey:@"mento_img"]];
                    
                    UIImage *profileImg = nil;
                    NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                    profileImg = [[UIImage alloc] initWithData:firstImageData];
                    
                    [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell.mentorImageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                    });
                });
            }
        }
        // 마지막 셀 체크 페이지 더보기 처리
        if (indexPath.row == _personList.count - 1) {
            
            if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
                
                [self.delegate tableView:tableView totalPageCount:_personList.count];
            }
        }
        
    }else{
        // 이미지 캐시 바인딩
        NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [data objectForKey:@"img"]];
        if([[data objectForKey:@"img"] isEqualToString:@""]){
            [cell.mentorImageView setImage:[UIImage imageNamed:@"contents_profile_default"]];
        }else{
            
            if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                [cell.mentorImageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
            }else {
                char const * s = [profileImageIdentifier  UTF8String];
                dispatch_queue_t queue = dispatch_queue_create(s, 0);
                dispatch_async(queue, ^{
                    
                    NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [data objectForKey:@"img"]];
                    
                    UIImage *profileImg = nil;
                    NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                    profileImg = [[UIImage alloc] initWithData:firstImageData];
                    
                    [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell.mentorImageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                    });
                });
            }
  
        }
        
        cell.addButton.hidden = YES;
        cell.mentorButtonImage.hidden = YES;
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
