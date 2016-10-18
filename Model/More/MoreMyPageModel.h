//
//  MoreMyPageModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreMyPageNickNameCell.h"
#import "MoreMyPagePasswordChangeCell.h"
#import "MoreMyPageFetusHeaderCell.h"
#import "MoreMyPageFetusContentsCell.h"
#import "MorePointCell.h"

#pragma mark 공통 프로토콜
@protocol MoreMyPageModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView MoreMyPageModelSelectedIndexPath : (NSIndexPath *) indexPath;

- (void) tableView : (UITableView *) tableView totalPageCount : (NSInteger) count;

@end

#pragma mark 닉네임 변경 프로토콜
@protocol MoreMyNickNameChangeModelDelegate <NSObject>

@optional

- (void) nickNameChageTouch;

@end

#pragma mark 닉네임 변경 모델
@interface MoreMyNickNameChangeModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id<MoreMyNickNameChangeModelDelegate> delegate;

@end

#pragma mark 비밀번호 변경 모델
@interface MoreMyPagePasswordChangeModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@end

@protocol MoreMyPageFetusContentsCellDelegate <NSObject>

@optional

-(void)deleteBabyNicknameButton:(id)sender;
-(void)changeCell:(NSInteger)count;

@end
#pragma mark 태아정보 변경 모댈
@interface MoreMyPageFetusChangeModel : NSObject<UITableViewDelegate, UITableViewDataSource, MoreMyPageFetusContentsCellModel, MoreMyPageFetusHeaderCellDelegate>

@property (strong, nonatomic) NSMutableArray *arrayList;
@property (strong, nonatomic) id<MoreMyPageFetusContentsCellDelegate> delegate;

@end

#pragma mark 포인트
@interface MoreMyPagePointModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *arrayList;

@property (strong, nonatomic) id<MoreMyPageModelDelegate> delegate;

@end
