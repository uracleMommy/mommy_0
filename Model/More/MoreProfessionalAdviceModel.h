//
//  MoreProfessionalAdviceModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoreProfessionalAdviceModelDelegate;

@interface MoreProfessionalAdviceModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) id<MoreProfessionalAdviceModelDelegate> delegate;

@end

@protocol MoreProfessionalAdviceModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView moreProfessionalSelectedIndexPath : (NSIndexPath *) indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

@end
