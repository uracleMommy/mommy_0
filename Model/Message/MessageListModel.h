//
//  MessageListModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EnumType.h"

@protocol MessageListModelDelegate;

@interface MessageListModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *listArray; // 리스트 정보

@property (strong, nonatomic) NSMutableDictionary *listImgArray; // 프로필 이미지 캐쉬 저장용 딕셔너리

@property (assign) ModifyStatus modifyStatus; // 편집모드

@property (strong, nonatomic) id<MessageListModelDelegate> delegate;

@property (strong, nonatomic) NSMutableDictionary *cachedImages;

@end

@protocol MessageListModelDelegate <NSObject>

@required

- (void) tableView : (UITableView *) tableView selectedIndexPath : (NSIndexPath *) indexPath;

@optional

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

@end
