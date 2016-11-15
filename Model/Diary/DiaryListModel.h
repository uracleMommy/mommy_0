//
//  DiaryListModel.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DiaryListBasicCustomCell.h"
#import "DiaryListImageCustomCell.h"
#import "MommyUtils.h"
#import "MommyRequest.h"
#import "GTLCalendarEvent.h"
#import "GTLDateTime.h"

@protocol DiaryListModelDelegate <NSObject>

@optional
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;
-(void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count;

@end

@interface DiaryListModel : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *diaryList;
@property (nonatomic, strong) NSString *selectedDate;
@property (strong, nonatomic) id<DiaryListModelDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;
@property (strong, nonatomic) NSMutableDictionary *googleCalendarDic;

@end
