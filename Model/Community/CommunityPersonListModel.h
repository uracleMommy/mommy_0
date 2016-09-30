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

@protocol CommunityPersonListModelDelegate <NSObject>

@optional
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface CommunityPersonListModel : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *personList;
@property (strong, nonatomic) id<CommunityPersonListModelDelegate> delegate;
@property (nonatomic, assign) Boolean addMentorButtonFlag;

@end
