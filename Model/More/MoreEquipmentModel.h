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


#pragma mark 연결된 기기 리스트 모델
@interface MoreEquipmentListModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@end

#pragma mark 기기 선택 모델
@interface MoreEquipmentChoiceModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@property (strong, nonatomic) id<MoreEquipmentChoiceModelDelegate> delegate;

@end

#pragma 기기 검색중 모델
@interface MoreEquipmentSearchingModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@end

#pragma 검색된 기기 선택 모델
@interface MoreEquipmentSelectModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) id<MoreEquipmentChoiceModelDelegate> delegate;

@end
