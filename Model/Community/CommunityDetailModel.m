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
        _cachedImages = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detailList count]+3;
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
            
//            cell.writerNicknameLabel.text = [_motherData objectForKey:@"mento_nickname"];
//            cell.regDateLabel.text = [_motherData objectForKey:@"reg_dttm"];
            
//            cell.contentsLabel.text = [_motherData objectForKey:@"content"];
            
            cell.writerNicknameLabel.text = [_motherData objectForKey:@"mento_nickname"];
            cell.regDateLabel.text = [[MommyUtils sharedGlobalData] getMommyDate:[_motherData objectForKey:@"reg_dttm"]];
            NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [_motherData objectForKey:@"mento_img"]];
            cell.personKey = [_motherData objectForKey:@"mento_key"];
            cell.personNickname = [_motherData objectForKey:@"mento_nickname"];
            if([[_motherData objectForKey:@"mento_img"] isEqualToString:@""]){
                [cell.writerPersonImage setImage:[UIImage imageNamed:@"contents_profile_default"] forState:UIControlStateNormal];
            }else{
                
                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                    [cell.writerPersonImage setImage:[_cachedImages valueForKey:profileImageIdentifier]forState:UIControlStateNormal];
                }else {
                    char const * s = [profileImageIdentifier  UTF8String];
                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                    dispatch_async(queue, ^{
                        
                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [_motherData objectForKey:@"mento_img"]];
                        
                        UIImage *profileImg = nil;
                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                        
                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.writerPersonImage setImage:[_cachedImages valueForKey:profileImageIdentifier] forState:UIControlStateNormal];
                        });
                    });
                }
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
            CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 35.0, 0);
            
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

            cell.contentTextView.text = [_motherData objectForKey:@"content"];
            UILabel *gettingSizeLabel = [[UILabel alloc] init];
            gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize maximumLabelSize = CGSizeMake(310, CGFLOAT_MAX);
            
            CGRect textRect = [cell.contentTextView.text boundingRectWithSize:maximumLabelSize
                                                                    options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                                 attributes:@{NSFontAttributeName:cell.contentTextView.font}
                                                                    context:nil];
            
            cell.contentsHeightConstraint.constant = textRect.size.height + 20;
           
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CELL2];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"CommunityDetailReplyPeopleInfoCell" bundle:nil] forCellReuseIdentifier:CELL2];
                
                cell = [tableView dequeueReusableCellWithIdentifier:CELL2];
            }
            
            //초기화
            
//            cell.replyPersonImage01.hidden = YES;
//            cell.replyPersonImage02.hidden = YES;
//            cell.replyPersonImage03.hidden = YES;
//            cell.replyPersonImage04.hidden = YES;
//            cell.replyPersonImage05.hidden = YES;
            NSArray *replayPerson = [[NSArray alloc]initWithArray: [_replyInfo objectForKey:@"mento_list"]];
            for(int i=0 ; i<5 ; i++){
                if([replayPerson count] > i){
                    NSDictionary *result = [replayPerson objectAtIndex:i];
                    
                    NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [result objectForKey:@"img"]];
                    

                    switch (i) {
                        case 0:
                        {
                            cell.replyPersonImage01.hidden = NO;
                            if([profileImageIdentifier isEqualToString:@"Cell"]){
                                [cell.replyPersonImage01 setImage:[UIImage imageNamed:@"contents_profile_default"]];
                            }else{
                                
                                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                                    [cell.replyPersonImage01 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                }else {
                                    char const * s = [profileImageIdentifier  UTF8String];
                                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                                    dispatch_async(queue, ^{
                                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                                        
                                        UIImage *profileImg = nil;
                                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                                        
                                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [cell.replyPersonImage01 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                        });
                                    });
                                }
   
                            }
                            break;
                        }
                        case 1:
                        {
                            cell.replyPersonImage02.hidden = NO;
                            if([profileImageIdentifier isEqualToString:@"Cell"]){
                                [cell.replyPersonImage02 setImage:[UIImage imageNamed:@"contents_profile_default"]];
                            }else{
                                
                                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                                    [cell.replyPersonImage02 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                }else {
                                    char const * s = [profileImageIdentifier  UTF8String];
                                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                                    dispatch_async(queue, ^{
                                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                                        
                                        UIImage *profileImg = nil;
                                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                                        
                                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [cell.replyPersonImage02 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                        });
                                    });
                                }

                            }
                            break;
                        }
                            
                        case 2:
                        {
                            cell.replyPersonImage03.hidden = NO;
                            if([profileImageIdentifier isEqualToString:@"Cell"]){
                                [cell.replyPersonImage03 setImage:[UIImage imageNamed:@"contents_profile_default"]];
                            }else{
                                
                                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                                    [cell.replyPersonImage03 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                }else {
                                    char const * s = [profileImageIdentifier  UTF8String];
                                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                                    dispatch_async(queue, ^{
                                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                                        
                                        UIImage *profileImg = nil;
                                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                                        
                                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [cell.replyPersonImage03 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                        });
                                    });
                                }
                            }
                            break;
                        }
                        case 3:
                        {
                            
                            cell.replyPersonImage04.hidden = NO;
                            if([profileImageIdentifier isEqualToString:@"Cell"]){
                                [cell.replyPersonImage04 setImage:[UIImage imageNamed:@"contents_profile_default"]];
                            }else{
                                
                                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                                    [cell.replyPersonImage04 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                }else {
                                    char const * s = [profileImageIdentifier  UTF8String];
                                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                                    dispatch_async(queue, ^{
                                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                                        
                                        UIImage *profileImg = nil;
                                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                                        
                                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [cell.replyPersonImage04 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                        });
                                    });
                                }
                            }
                            break;
                        }
                            
                        case 4:
                        {
                            cell.replyPersonImage05.hidden = NO;
                            
                            if([profileImageIdentifier isEqualToString:@"Cell"]){
                                [cell.replyPersonImage05 setImage:[UIImage imageNamed:@"contents_profile_default"]];
                            }else{
                                
                                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                                    [cell.replyPersonImage05 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                }else {
                                    char const * s = [profileImageIdentifier  UTF8String];
                                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                                    dispatch_async(queue, ^{
                                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                                        
                                        UIImage *profileImg = nil;
                                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                                        
                                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [cell.replyPersonImage05 setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                                        });
                                    });
                                }
                            }
                            
                            break;
                        }
                            
                        default:
                            break;
                    }
                }
            }
            
            
            if([[_replyInfo objectForKey:@"like_cnt"] intValue] != 0){
//                cell.likeCountLabel.hidden = NO;
//                cell.likeButton.hidden = NO;
                cell.likeCountLabel.text = [NSString stringWithFormat:@"%@", [_replyInfo objectForKey:@"like_cnt"]];
            }else{
//                cell.likeCountLabel.hidden = YES;
//                cell.likeButton.hidden = YES;
                cell.likeCountLabel.text = [NSString stringWithFormat:@"0"];
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
            NSDictionary *result = [_detailList objectAtIndex:indexPath.row-3];
            NSLog(@"PSH %d", indexPath.row-3);
            
            UILabel *gettingSizeLabel = [[UILabel alloc] init];
            gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize maximumLabelSize = CGSizeMake(310, CGFLOAT_MAX);
            
            CGRect textRect = [cell.replyContentTextField.text boundingRectWithSize:maximumLabelSize
                                                                      options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                                   attributes:@{NSFontAttributeName:cell.replyContentTextField.font}
                                                                      context:nil];
            
            cell.replyContentsHeightConstraint.constant = textRect.size.height;
            
            cell.replyRegDate.text = [[MommyUtils sharedGlobalData] getMommyDate:[result objectForKey:@"reg_dttm"]];
            cell.replyPersonKickname.text = [result objectForKey:@"mento_nickname"];
            cell.replyContentTextField.text = [result objectForKey:@"content"];
            cell.replyContentsHeightConstraint.constant = textRect.size.height;
            cell.personKey = [result objectForKey:@"mento_key"];
            cell.personNickname = [result objectForKey:@"mento_nickname"];
            
            NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [result objectForKey:@"img"]];
            if([[result objectForKey:@"img"] isEqualToString:@""]){
//                dispatch_sync(dispatch_get_main_queue(), ^{
                    [cell.replyPersonButton setImage:[UIImage imageNamed:@"contents_profile_default"] forState:UIControlStateNormal];
//                });
            }else{
                
                if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                    [cell.replyPersonButton setImage:[_cachedImages valueForKey:profileImageIdentifier]forState:UIControlStateNormal];
                }else {
                    char const * s = [profileImageIdentifier  UTF8String];
                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                    dispatch_async(queue, ^{
                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                        
                        UIImage *profileImg = nil;
                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                        
                        [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.replyPersonButton setImage:[_cachedImages valueForKey:profileImageIdentifier] forState:UIControlStateNormal];
                        });
                    });
                }
            }
            
            CALayer *border = [CALayer layer];
            border.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0] CGColor];
            border.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height);
            border.borderWidth = 1.0f;
            [cell.layer addSublayer:border];
            

            break;
        }
    }
    
    cell.delegate = self;
    
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
    switch (indexPath.row) {
        case 0:
            return 73;
          break;
        case 1:
            return UITableViewAutomaticDimension;
            break;
        case 2:
            return 60;
            break;
        default:
            return UITableViewAutomaticDimension;
            break;
    }
    
}

-(void) moreButtonAction:(id)sender point:(CGPoint)point{
     [_delegate moreButtonAction:sender point:point];   
}

-(void) showProfilePopupViewAction:(NSString *)personKey personNickname:(NSString *)personNickname{
    [_delegate showProfilePopupViewAction:personKey personNickname:(NSString *)personNickname];
}

@end
