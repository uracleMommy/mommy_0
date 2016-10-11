//
//  CommunityPersonListModel.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommunityPersonListCustomCell.h"
#import "MommyUtils.h"
#import "MommyRequest.h"

@protocol CommunityPersonListModelDelegate <NSObject>

@optional
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;
-(void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count;
@end

@interface CommunityPersonListModel : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *personList;
@property (strong, nonatomic) id<CommunityPersonListModelDelegate> delegate;
@property (nonatomic, assign) Boolean addMentorButtonFlag;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;

@end
