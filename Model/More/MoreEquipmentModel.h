//
//  MoreEquipmentModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreEquipmentListCell.h"
#import "MoreEquipmentChoiceCell.h"
#import "MoreEquipmentSelectCell.h"

@protocol MoreEquipmentChoiceModelDelegate <NSObject>

@required

- (void) tableView : (UITableView *) tableView MoreEquipmentChoiceSelectedRow : (NSIndexPath *) indexPath;

@end



@interface MoreEquipmentListModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@end

@interface MoreEquipmentChoiceModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@property (strong, nonatomic) id<MoreEquipmentChoiceModelDelegate> delegate;

@end

@interface MoreEquipmentSearchingModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@end

@interface MoreEquipmentSelectModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@property (strong, nonatomic) id<MoreEquipmentChoiceModelDelegate> delegate;

@end
