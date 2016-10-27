//
//  CommunityNewspeedListModel.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MommyUtils.h"
#import "CommunityNewspeedBasicCustomCell.h"
#import "CommunityNewspeedImageCustomCell.h"

@protocol CommunityNewspeedListModelDelegate <NSObject>

@optional
- (void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count;
- (void)collectionView:(NSDictionary *)imageArr didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedCell:(id)sender;
- (void) moreButtonAction:(id)sender point:(CGPoint)point;
- (void) moveDetailViewButtonAction:(NSDictionary *)data;
- (void) moveWriteMessageViewAction:(id)sender;
- (void) showProfilePopupViewAction:(id)sender;

@end

@interface CommunityNewspeedListModel : NSObject<UITableViewDelegate, UITableViewDataSource, CommunityNewspeedBasicCustomCellDelegate, CommunityNewspeedImageCustomCellDelegate>

@property (nonatomic, strong) NSMutableArray *newspeedList;
@property (strong, nonatomic) id<CommunityNewspeedListModelDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;
@property (strong, nonatomic) NSMutableArray *cellTypeDic;

@end
