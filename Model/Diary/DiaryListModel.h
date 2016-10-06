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

@protocol DiaryListModelDelegate <NSObject>

@optional
-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface DiaryListModel : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *diaryList;
@property (strong, nonatomic) id<DiaryListModelDelegate> delegate;

@property (strong, nonatomic) NSMutableDictionary *cachedImages;

@end
