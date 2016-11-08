//
//  CommunityDetailModel.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommunityDetailCells.h"
#import "MommyUtils.h"
#import "MommyRequest.h"

@protocol CommunityDetailModelDelegate <NSObject>

@optional
//- (void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;
- (void)moreButtonAction:(id)sender point:(CGPoint)point;
- (void)showProfilePopupViewAction:(NSString *)personKey personNickname:(NSString *)personNickname;

@end

@interface CommunityDetailModel : NSObject <UITableViewDataSource, UITableViewDelegate, CommunityDetailCellsDelgate>

@property (nonatomic, strong) NSMutableArray *detailList;
@property (nonatomic, strong) NSDictionary *replyInfo;
@property (nonatomic, strong) NSMutableArray *likePersonData;
@property (strong, nonatomic) id<CommunityDetailModelDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;
@property (strong, nonatomic) NSDictionary *motherData;

@end
