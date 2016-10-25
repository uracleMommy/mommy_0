//
//  WeekProgramModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeekProgramModelDelegate;

@interface WeekProgramModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) id<WeekProgramModelDelegate> delegate;

@end

@protocol WeekProgramModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

@end
