//
//  MoreBloodPressureModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreBloodPressureChartCell.h"

@protocol MoreBloodPressureModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView MoreBloodPressureModelSelectedIndexPath : (NSIndexPath *) indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

- (void) tableView:(UITableView *) tableView deleteIndex : (NSInteger) row;

- (void) goChartPrevious;

- (void) goChartNext;

@end

@interface MoreBloodPressureModel : NSObject<UITableViewDelegate, UITableViewDataSource, MoreBloodPressureChartCellDelegate>

@property (strong, nonatomic) NSURLRequest *chartRequest;

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) NSMutableArray *buttonArray;

@property (strong, nonatomic) NSDictionary *dicList;

@property (strong, nonatomic) id<MoreBloodPressureModelDelegate> delegate;

@end
