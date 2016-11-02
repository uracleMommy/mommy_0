//
//  MessageListModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageListModel.h"
#import "MessageListCell.h"
#import "MommyUtils.h"
#import "MommyRequest.h"

@implementation MessageListModel

- (id) init {
    
    if (self = [super init]) {
        
        _listArray = [[NSMutableArray alloc] init];
        _cachedImages = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierNoticeCell = @"MessageListCell";
    
    UINib *reuseCell = [UINib nibWithNibName:@"MessageListCell" bundle:nil];
    [tableView registerNib:reuseCell forCellReuseIdentifier:CellIdentifierNoticeCell];
    
    MessageListCell *cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    
    if (cell == nil) {
        
        cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierNoticeCell];
    }
    
    if (_modifyStatus == ModifyMode) {
        
        if (cell.imgProfile.subviews.count == 0) {
            
            UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
            alphaView.tag = 0;
            [alphaView setBackgroundColor:[UIColor blackColor]];
            alphaView.alpha = 0.7f;
            [cell.imgProfile addSubview:alphaView];
        }
        
        // 체크 로직
        // 해당로우의 체크값이 1일때
        NSDictionary *cellDic = _listArray[indexPath.row];
        
        if ([cellDic[@"check"] isEqualToString:@"1"]) {
            
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contents_message_check"]];
            img.tag = 1;
            [img setFrame:CGRectMake(0, 0, cell.imgProfile.frame.size.width, cell.imgProfile.frame.size.height)];
            [cell.imgProfile addSubview:img];
        }
        else {
            
            for (UIView *subView in cell.imgProfile.subviews) {
                
                if (subView.tag == 1) {
                    
                    [subView removeFromSuperview];
                }
            }
        }
        
    }
    
    else {
        
        if (cell.imgProfile.subviews.count > 0) {
            
            for (UIView *subView in cell.imgProfile.subviews) {
                                
                [subView removeFromSuperview];
            }
        }
    }
    
    // 셀 바인딩
    
    NSDictionary *dic = _listArray[indexPath.row];
    cell.lblName.text = dic[@"from_nickname"];
    cell.lblContent.text = dic[@"content"];
    cell.lblWriteTime.text = [[MommyUtils sharedGlobalData] getMommyDate:dic[@"reg_dttm"]];
    
    // 이미지 캐시 바인딩
    NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", dic[@"img"]];
    
    if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
        
        [cell.imgProfile setImage:[_cachedImages valueForKey:profileImageIdentifier]];
    }
    else {
        
        NSString *fileImageName = dic[@"img"];
        
        // 이미지가 있을때
        if (!([dic[@"img"] isEqual:[NSNull null]] || fileImageName == nil || [fileImageName isEqualToString:@""])) {
            
            char const * s = [profileImageIdentifier  UTF8String];
            dispatch_queue_t queue = dispatch_queue_create(s, 0);
            dispatch_async(queue, ^{
                
                NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], fileImageName];
                
                UIImage *profileImg = nil;
                NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                profileImg = [[UIImage alloc] initWithData:firstImageData];
                
                [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [cell.imgProfile setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                });
            });
        }
        // 이미지가 없을때
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.imgProfile setImage:[UIImage imageNamed:@"contents_profile_default"]];
            });
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 점선처리
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:cell.bounds];
    [shapeLayer setPosition:cell.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, tableView.frame.size.width - 32.0, 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[cell.lblDotLine layer] addSublayer:shapeLayer];
    
    // 마지막 셀 체크 페이지 더보기 처리
    if (indexPath.row == _listArray.count - 1 && _listArray.count % 30 == 0) {
        
        if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
            
            [self.delegate tableView:tableView totalPageCount:_listArray.count];
        }
    }
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 136.0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // API 나오면 세부처리
    if ([self.delegate respondsToSelector:@selector(tableView:selectedIndexPath:)]) {
        
        [self.delegate tableView:tableView selectedIndexPath:indexPath];
    }
}

@end
