//
//  MoreEnvironmentModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreEnvironmentMyPageCell.h"
#import "MoreEnvironmentAlramCell.h"
#import "MoreEnvironmentCalendarCell.h"
#import "MoreEnvironmentAgreementCell.h"
#import "MoreEnvironmentVersionInfoCell.h"
#import "MoreEnvironmentCalendarListCell.h"

#pragma mark 공통 프로토콜
@protocol MoreEnvironmentListModelDelegate <NSObject>

@optional

- (void) tableView : (UITableView *) tableView MoreMyPageModelSelectedIndexPath : (NSIndexPath *) indexPath;

-(void)googleAuthLinkAction;

@end

#pragma mark 환경설정 모델
@interface MoreEnvironmentListModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id<MoreEnvironmentListModelDelegate> delegate;

@end

#pragma mark 캘린더 연결 모델
@interface MoreEnvironmentCalendarModal : NSObject<UITableViewDelegate, UITableViewDataSource, MoreEnvironmentCalendarListCellDelegate>

@property (strong, nonatomic) id<MoreEnvironmentListModelDelegate> delegate;
@property (assign, nonatomic) Boolean *authFlag;
@property (strong, nonatomic) NSString *accountText;

@end
