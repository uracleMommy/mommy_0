//
//  ActiveMassModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActiveMassChartView.h"

@protocol ActiveMassModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

- (void) goChartPrevious;

- (void) goChartNext;

@end

@interface ActiveMassModel : NSObject<UITableViewDelegate, UITableViewDataSource, ActiveMassChartViewDelegate>

@property (strong, nonatomic) NSDictionary *dicList;

@property (strong, nonatomic) id<ActiveMassModelDelegate> delegate;

@property (strong, nonatomic) NSURLRequest *chartRequest;

@end
