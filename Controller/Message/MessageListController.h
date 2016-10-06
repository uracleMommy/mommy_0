//
//  MessageListController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MessageListModel.h"

@interface MessageListController : CommonViewController<MessageListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign) ModifyStatus modifyStatus;

@property (strong, nonatomic) NSDictionary *dicData;

@property (strong, nonatomic) MessageListModel *messageListModel;

@property (strong, nonatomic) UIButton *btnCellMode;

@property (strong, nonatomic) UIButton *btnClose;

@property (assign) BOOL currentLastPageStatus; // 현재 마지막 페이지까지 로드가 되어있는지 여부

@end
