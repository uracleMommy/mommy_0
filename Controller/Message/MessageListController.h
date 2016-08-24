//
//  MessageListController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListModel.h"

typedef enum {
    
    NormalMode = 0,
    ModifyMode = 1
    
} ModifyStatus;

@interface MessageListController : UIViewController<MessageListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)cellSelect:(id)sender;

@property (assign) ModifyStatus modifyStatus;

@property (strong, nonatomic) MessageListModel *messageListModel;

@end