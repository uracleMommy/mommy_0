//
//  PushNoticeModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PushNoticeModelDelegate;

@interface PushNoticeModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) id<PushNoticeModelDelegate> delegate;

@end

@protocol PushNoticeModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView didSelectRowAtIndexPath : (NSIndexPath *) indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

@end
