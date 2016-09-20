//
//  MoreWeekCheckModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoreWeekCheckModelDelegate;

@interface MoreWeekCheckModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@property (strong, nonatomic) id<MoreWeekCheckModelDelegate> delegate;

@end

@protocol MoreWeekCheckModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView selectedRowIndex : (NSInteger) index;

@end