//
//  WeightChartModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeightChartViewCell.h"
#import "WeightDetailInfoHeaderCell.h"
#import "WeightDetailInfoContentsCell.h"
#import "WeightDetailInfoFooterCell.h"
#import "EnumType.h"


@protocol WeightChartModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

- (void) goChartPrevious;

- (void) goChartNext;

@end

@interface WeightChartModel : NSObject<UITableViewDelegate, UITableViewDataSource, WeightChartViewDelegate>

@property (strong, nonatomic) NSArray *arrayList;

@property (assign, nonatomic) WeigthChartKind chartKind;

@property (strong, nonatomic) NSDictionary *dicList;

@property (strong, nonatomic) NSURLRequest *chartRequest;

@property (strong, nonatomic) id<WeightChartModelDelegate> delegate;


@end
