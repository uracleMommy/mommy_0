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
        _cachedImages = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_diaryList count] + [_googleCalendarDic[_selectedDate] count];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate tableView:tableView selectedIndexPath:indexPath];
}

- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    [_delegate tableView:tableView totalPageCount:count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(indexPath.row < [_googleCalendarDic[_selectedDate] count]){
        NSLog(@"%ld", [indexPath row]);
        NSDictionary *data = [_googleCalendarDic[_selectedDate] objectAtIndex:[indexPath row]];
        
        DiaryListBasicCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        
        if(cell == nil){
            [tableView registerNib:[UINib nibWithNibName:@"DiaryListBasicCustomCell" bundle:nil] forCellReuseIdentifier:BASIC_CELL_ID];
            
            cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
        }
        
        if(data[@"start"][@"dateTime"] != nil){
            cell.regDateLabel.text = [self getyyyyMMddeeee:data[@"start"][@"dateTime"]];
        }else{
            cell.regDateLabel.text = [NSString stringWithFormat:@"%@%@", [self getyyyyMMdd:data[@"start"][@"date"]], @" 00:01"];
        }
        cell.emoticonImageView.image = [UIImage imageNamed: @"contents_icon_emoticon08"];
        cell.emoticonLabel.textColor = [UIColor colorWithRed:150.0f/255.0f green:183.0f/255.0f blue:55.0f/255.0f alpha:1.0f];
        cell.emoticonLabel.text = @"개인";
        
        cell.titleLabel.text = [data objectForKey:@"summary"];
        cell.tag = 2;
        cell.googleCalendarDic = [[NSDictionary alloc]initWithDictionary:data];
        
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
        CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 90.0, 0);
        
        [firstShapeLayer setPath:firstPath];
        CGPathRelease(firstPath);
        [[cell.lineLabel layer] addSublayer:firstShapeLayer];

        return cell;
    }else{
        NSLog(@"%ld", [indexPath row]);
        NSLog(@"%ld", [_googleCalendarDic[_selectedDate] count]);
        NSDictionary *data = [_diaryList objectAtIndex:[indexPath row]-[_googleCalendarDic[_selectedDate] count]];
        
        NSDictionary *emoticon = @{
                                   @"501" : @{
                                           @"image" : [UIImage imageNamed:@"contents_icon_emoticon01"],
                                           @"color" : [UIColor colorWithRed:249.0f/255.0f green:105.0f/255.0f blue:78.0f/255.0f alpha:1.0f],
                                           @"text" : @"행복"
                                           },
                                   @"502" : @{
                                           @"image" : [UIImage imageNamed:@"contents_icon_emoticon02"],
                                           @"color" : [UIColor colorWithRed:249.0f/255.0f green:179.0f/255.0f blue:78.0f/255.0f alpha:1.0f],
                                           @"text" : @"놀람"
                                           },
                                   @"503" : @{
                                           @"image" : [UIImage imageNamed:@"contents_icon_emoticon03"],
                                           @"color" : [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f],
                                           @"text" : @"보통"
                                           },
                                   @"504" : @{
                                           @"image" : [UIImage imageNamed:@"contents_icon_emoticon04"],
                                           @"color" : [UIColor colorWithRed:156.0f/255.0f green:113.0f/255.0f blue:228.0f/255.0f alpha:1.0f],
                                           @"text" : @"즐거움"
                                           },
                                   @"505" : @{
                                           @"image" : [UIImage imageNamed:@"contents_icon_emoticon05"],
                                           @"color" : [UIColor colorWithRed:100.0f/255.0f green:140.0f/255.0f blue:226.0f/255.0f alpha:1.0f],
                                           @"text" : @"슬픔"
                                           },
                                   @"506" : @{
                                           @"image" : [UIImage imageNamed:@"contents_icon_emoticon06"],
                                           @"color" : [UIColor colorWithRed:220.0f/255.0f green:82.0f/255.0f blue:82.0f/255.0f alpha:1.0f],
                                           @"text" : @"화남"
                                           },
                                   @"507" : @{
                                           @"image" : [UIImage imageNamed: @"contents_icon_emoticon07"],
                                           @"color" : [UIColor colorWithRed:150.0f/255.0f green:183.0f/255.0f blue:55.0f/255.0f alpha:1.0f],
                                           @"text" : @"우울"
                                           }
                                   };
        
        if([data objectForKey:@"img"] && ![[data objectForKey:@"img"] isEqual:[NSNull null]] && ![[data objectForKey:@"img"] isEqualToString:@""]){
            
            DiaryListImageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"DiaryListImageCustomCell" bundle:nil] forCellReuseIdentifier:IMAGE_CELL_ID];
                
                cell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];
            }
            
            if([data objectForKey:@"isvalid"] && [[data objectForKey:@"isvalid"] isEqualToString:@"N"]){
                cell.isvalidImageView.image = [UIImage imageNamed:@"contents_icon_temsave.png"];
                cell.regDateLabel.text = @"(임시저장)";
                cell.regDateLabel.textColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
            }else{
                cell.regDateLabel.text = [[MommyUtils sharedGlobalData] getMommyDate:[data objectForKey:@"reg_dttm"]];
            }
            
            
            if([data objectForKey:@"emoticon"] && ![[data objectForKey:@"emoticon"] isEqual:[NSNull null]] && ![[data objectForKey:@"emoticon"] isEqualToString:@""]){
                cell.emoticonImageView.image = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"image"];
                cell.emoticonLabel.textColor = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"color"];
                cell.emoticonLabel.text = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"text"];
            }else{
                cell.emoticonImageView.image = nil;
                //            cell.emoticonLabel.textColor = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"color"];
                cell.emoticonLabel.text = @"";
            }
            
            cell.tag = 1;
            cell.titleLabel.text = [data objectForKey:@"title"];
            cell.diaryKey = [data objectForKey:@"diary_key"];
            
            
            // 이미지 캐시 바인딩
            NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [data objectForKey:@"img"]];
            
            if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
                [cell.contentImageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
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
                        [cell.contentImageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
                    });
                });
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
            CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 90.0, 0);
            
            [firstShapeLayer setPath:firstPath];
            CGPathRelease(firstPath);
            
            [[cell.lineLabel layer] addSublayer:firstShapeLayer];
            
            // 마지막 셀 체크 페이지 더보기 처리
            if (indexPath.row == _diaryList.count+[_googleCalendarDic[_selectedDate] count] - 1) {
                
                if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
                    
                    [self.delegate tableView:tableView totalPageCount:_diaryList.count];
                }
            }
            
            
            return cell;
        }else{
            DiaryListBasicCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
            
            if(cell == nil){
                [tableView registerNib:[UINib nibWithNibName:@"DiaryListBasicCustomCell" bundle:nil] forCellReuseIdentifier:BASIC_CELL_ID];
                
                cell = [tableView dequeueReusableCellWithIdentifier:BASIC_CELL_ID];
            }
            //      cell.delegate = self;
            
            if([data objectForKey:@"isvalid"] && [[data objectForKey:@"isvalid"] isEqualToString:@"N"]){
                cell.isvalidImageView.image = [UIImage imageNamed:@"contents_icon_temsave.png"];
                cell.regDateLabel.text = @"(임시저장)";
                cell.regDateLabel.textColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
            }else{
                cell.regDateLabel.text = [[MommyUtils sharedGlobalData] getMommyDate:[data objectForKey:@"reg_dttm"]];
            }
            
            
            if([data objectForKey:@"emoticon"] && ![[data objectForKey:@"emoticon"] isEqual:[NSNull null]] && ![[data objectForKey:@"emoticon"] isEqualToString:@""]){
                cell.emoticonImageView.image = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"image"];
                cell.emoticonLabel.textColor = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"color"];
                cell.emoticonLabel.text = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"text"];
            }else{
                cell.emoticonImageView.image = nil;
                //            cell.emoticonLabel.textColor = [[emoticon objectForKey:[data objectForKey:@"emoticon"]] objectForKey:@"color"];
                cell.emoticonLabel.text = @"";
            }
            
            cell.titleLabel.text = [data objectForKey:@"title"];
            cell.tag = 0;
            cell.diaryKey = [data objectForKey:@"diary_key"];
            
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
            CGPathAddLineToPoint(firstPath, NULL, tableView.frame.size.width - 90.0, 0);
            
            [firstShapeLayer setPath:firstPath];
            CGPathRelease(firstPath);
            [[cell.lineLabel layer] addSublayer:firstShapeLayer];
            
            // 마지막 셀 체크 페이지 더보기 처리
            if (indexPath.row == _diaryList.count+[_googleCalendarDic[_selectedDate] count] - 1) {
                
                if ([self.delegate respondsToSelector:@selector(tableView:totalPageCount:)]) {
                    
                    [self.delegate tableView:tableView totalPageCount:_diaryList.count];
                }
            }
            
            return cell;
        }
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (NSString *) getyyyyMMddeeee : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"YYYY.MM.dd HH:mm"];
    NSString *yyyymmddeeee = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmddeeee;
}

- (NSString *) getyyyyMMdd : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *yyyymmddeeee = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmddeeee;
}

@end
