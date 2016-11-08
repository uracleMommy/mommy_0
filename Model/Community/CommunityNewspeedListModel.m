//
//  CommunityNewspeedListModel.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityNewspeedListModel.h"
#define BASIC_CELL_ID @"BASIC_CELL_ID"
#define IMAGE_CELL_ID @"IMAGE_CELL_ID"

@implementation CommunityNewspeedListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _newspeedList = [[NSMutableArray alloc]init];
        _cachedImages = [[NSMutableDictionary alloc]init];
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
    NSDictionary *data = [_newspeedList objectAtIndex:[indexPath row]];
    
    //이미지 존재
    if([data objectForKey:@"files"] && [[data objectForKey:@"files"] count] > 0){
        
        CommunityNewspeedImageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];
        
        if(cell == nil){
            [tableView registerNib:[UINib nibWithNibName:@"CommunityNewspeedImageCustomCell" bundle:nil] forCellReuseIdentifier:IMAGE_CELL_ID];
            
            cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];
        }
        [_cellTypeDic insertObject:@"IMAGE" atIndex:indexPath.row];
        cell.imageArr = [data objectForKey:@"files"];
        [cell.imageSlider reloadData];
        cell.data = data;
        
        cell.contentsLabel.text = [data objectForKey:@"content"];
        if([[data objectForKey:@"like_cnt"] intValue] != 0){
            cell.likeCountLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"like_cnt"]];
        }else{
            cell.likeCountLabel.text = @"좋아요";
        }
        
        if([[data objectForKey:@"reply_cnt"] intValue] != 0){
            cell.replyCountLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"reply_cnt"]];
        }else{
            cell.replyCountLabel.text = @"댓글";
        }
        cell.mentoNicknameLabel.text = [data objectForKey:@"mento_nickname"];
        cell.regDttmLabel.text = [[MommyUtils sharedGlobalData] getMommyDate:[data objectForKey:@"reg_dttm"]];
        if([[data objectForKey:@"like"] isEqualToString:@"Y"]){
            [cell.likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like_on"]];
        }else{
            [cell.likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like"]];
        }
        
        NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [data objectForKey:@"mento_img"]];
        
        if([profileImageIdentifier isEqualToString:@"Cell"]){
            
            [cell.mentoImageButton setImage:[UIImage imageNamed:@"contents_profile_default"] forState:UIControlStateNormal];
        }else{
            
            if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                [cell.mentoImageButton setImage:[_cachedImages valueForKey:profileImageIdentifier]forState:UIControlStateNormal];
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
                        [cell.mentoImageButton setImage:[_cachedImages valueForKey:profileImageIdentifier] forState:UIControlStateNormal];
                    });
                });
            }
    
        }
        
        
        cell.delegate = self;
        cell.tag = [indexPath indexAtPosition:1];
        
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
        CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 55.0, 0);
        
        [firstShapeLayer setPath:firstPath];
        CGPathRelease(firstPath);
        
        
        UILabel *gettingSizeLabel = [[UILabel alloc] init];
        gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize = CGSizeMake(310, CGFLOAT_MAX);
        
        CGRect textRect = [cell.contentsLabel.text boundingRectWithSize:maximumLabelSize
                                                                options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                             attributes:@{NSFontAttributeName:cell.contentsLabel.font}
                                                                context:nil];
        
        if(textRect.size.height >=66){
            cell.contentsHeightConstraint.constant = 66.0f;
        }else{
            cell.contentsHeightConstraint.constant = textRect.size.height;
        }
        
        [[cell.writerInfoView layer] addSublayer:firstShapeLayer];
        
        // 마지막 셀 체크 페이지 더보기 처리
        if (indexPath.row == _newspeedList.count - 1) {
            if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
                [self.delegate tableView:tableView totalPageCount:_newspeedList.count];
            }
        }
        
        return cell;

    }else{
        CommunityNewspeedBasicCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        [_cellTypeDic insertObject:@"BASIC" atIndex:indexPath.row];
//        [_cellTypeDic setObject:@"BASIC" forKey:indexPath.row];
        
        if(cell == nil){
            [tableView registerNib:[UINib nibWithNibName:@"CommunityNewspeedBasicCustomCell" bundle:nil] forCellReuseIdentifier:BASIC_CELL_ID];
            
            cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        }
        
        cell.contentsLabel.text = [data objectForKey:@"content"];
        if([[data objectForKey:@"like_cnt"] intValue] != 0){
            cell.likeCountLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"like_cnt"]];
        }else{
            cell.likeCountLabel.text = @"좋아요";
        }
        
        if([[data objectForKey:@"reply_cnt"] intValue] != 0){
            cell.replyCountLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"reply_cnt"]];
        }else{
            cell.replyCountLabel.text = @"댓글";
        }
        
        cell.mentoNicknameLabel.text = [data objectForKey:@"mento_nickname"];
        cell.regDttmLabel.text = [[MommyUtils sharedGlobalData] getMommyDate:[data objectForKey:@"reg_dttm"]];
        if([[data objectForKey:@"like"] isEqualToString:@"Y"]){
            [cell.likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like_on"]];
        }else{
            [cell.likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like"]];
        }
        NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [data objectForKey:@"mento_img"]];
        
        if([[data objectForKey:@"mento_img"] isEqualToString:@""]){
//            dispatch_sync(dispatch_get_main_queue(), ^{ 
                [cell.mentoImageButton setImage:[UIImage imageNamed:@"contents_profile_default"] forState:UIControlStateNormal];
//            });
        }else{
            if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                [cell.mentoImageButton setImage:[_cachedImages valueForKey:profileImageIdentifier]forState:UIControlStateNormal];
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
                        [cell.mentoImageButton setImage:[_cachedImages valueForKey:profileImageIdentifier] forState:UIControlStateNormal];
                    });
                });
            }
        }
        
        cell.delegate = self;
        cell.tag = [indexPath indexAtPosition:1];
        cell.data = data;
        
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
        CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 55.0, 0);
        
        [firstShapeLayer setPath:firstPath];
        CGPathRelease(firstPath);
        
        [[cell.writerInfoView layer] addSublayer:firstShapeLayer];
        
        UILabel *gettingSizeLabel = [[UILabel alloc] init];
        gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize maximumLabelSize = CGSizeMake(310, CGFLOAT_MAX);
        
        CGRect textRect = [cell.contentsLabel.text boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                              attributes:@{NSFontAttributeName:cell.contentsLabel.font}
                                                 context:nil];
        
        if(textRect.size.height >=66){
            cell.contentsHeightConstraint.constant = 66.0f;
        }else{
            cell.contentsHeightConstraint.constant = textRect.size.height;
        }
        
        // 마지막 셀 체크 페이지 더보기 처리
        if (indexPath.row == _newspeedList.count - 1) {
            if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
                [self.delegate tableView:tableView totalPageCount:_newspeedList.count];
            }
        }
        
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

- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    [_delegate tableView:tableView totalPageCount:count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


#pragma marks cell delegate

- (void)moreButtonAction:(id)sender point:(CGPoint)point{
    NSLog(@"moreButton");
    [_delegate moreButtonAction:sender point:point];
}

- (void)moveDetailViewButtonAction:(NSDictionary *)data{
    NSLog(@"moveDetailViewButtonAction");
    [_delegate moveDetailViewButtonAction:data];
}

- (void)moveWriteMessageViewAction:(id)sender{
    NSLog(@"moveWriteMessageViewAction");
    [_delegate moveWriteMessageViewAction:sender];
}

- (void)showProfilePopupViewAction:(id)sender{
    [_delegate showProfilePopupViewAction:sender];
}

- (void)likeButtonAction:(id)sender like:(NSString *)like type:(NSString *)type{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setObject:[[_newspeedList objectAtIndex:[sender tag]] objectForKey:@"community_key"] forKey:@"community_key"];
    [param setObject:like forKey:@"like"];
    
    if([type isEqualToString:@"BASIC"]){
            [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityLike authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
                if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                    if([[[data objectForKey:@"result"] objectForKey:@"like"] isEqualToString:@"Y"]){
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [[(CommunityNewspeedBasicCustomCell *)sender likeButtonImage] setImage:[UIImage imageNamed:@"contents_comm_icon_like_on"]];
                        });
                    }else{
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [[(CommunityNewspeedBasicCustomCell *)sender likeButtonImage] setImage:[UIImage imageNamed:@"contents_comm_icon_like"]];
                        });
                    }
                    
                    //like setting
                    if([[[data objectForKey:@"result"] objectForKey:@"like_cnt"] intValue] != 0){
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [(CommunityNewspeedBasicCustomCell *)sender likeCountLabel].text = [NSString stringWithFormat:@"%@", [[data objectForKey:@"result"] objectForKey:@"like_cnt"]];
                        });
                        NSMutableDictionary *changedData = [_newspeedList objectAtIndex:[sender tag]];
                        
                        [changedData setValue:[[data objectForKey:@"result"] objectForKey:@"like_cnt"] forKeyPath:@"like_cnt"];
                        
                        [_newspeedList replaceObjectAtIndex:[sender tag] withObject:changedData];
                    }else{
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [(CommunityNewspeedBasicCustomCell *)sender likeCountLabel].text = @"좋아요";
                        });
                    }
                    
                    
                }
            } error:^(NSError *error) {
                
            }];
    }else{
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityLike authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                if([[[data objectForKey:@"result"] objectForKey:@"like"] isEqualToString:@"Y"]){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[(CommunityNewspeedImageCustomCell *)sender likeButtonImage] setImage:[UIImage imageNamed:@"contents_comm_icon_like_on"]];
                    });
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[(CommunityNewspeedImageCustomCell *)sender likeButtonImage] setImage:[UIImage imageNamed:@"contents_comm_icon_like"]];
                    });
                }
                
                //like setting
                if([[[data objectForKey:@"result"] objectForKey:@"like_cnt"] intValue] != 0){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [(CommunityNewspeedImageCustomCell *)sender likeCountLabel].text = [NSString stringWithFormat:@"%@", [[data objectForKey:@"result"] objectForKey:@"like_cnt"]];
                    });
                    NSMutableDictionary *changedData = [_newspeedList objectAtIndex:[sender tag]];
                    
                    [changedData setValue:[[data objectForKey:@"result"] objectForKey:@"like_cnt"] forKeyPath:@"like_cnt"];
                    
                    [_newspeedList replaceObjectAtIndex:[sender tag] withObject:changedData];
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [(CommunityNewspeedBasicCustomCell *)sender likeCountLabel].text = @"좋아요";
                    });
                }
                
                
            }
        } error:^(NSError *error) {
            
        }];
     }
}

- (void)collectionView:(NSDictionary *)imageArr didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedCell:(id)sender{
    NSLog(@"PSH collectionView didSelecte : %li", (long)indexPath.row);
    
    [_delegate collectionView:imageArr didSelectItemAtIndexPath:indexPath selectedCell:sender];
}


@end
