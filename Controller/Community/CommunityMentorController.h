//
//  CommunityMentorController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityPersonListModel.h"

@protocol CommunityMentorDelegate <NSObject>

@optional
-(void) moveCommunityList;

@end

@interface CommunityMentorController : UIViewController<CommunityPersonListModelDelegate>

@property (strong, nonatomic) CommunityPersonListModel *tableListController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) id<CommunityMentorDelegate> delegate;


@end
