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

- (IBAction)cellSelect:(id)sender;

@property (assign) ModifyStatus modifyStatus;

@property (strong, nonatomic) MessageListModel *messageListModel;

- (IBAction)closeView:(id)sender;

@end