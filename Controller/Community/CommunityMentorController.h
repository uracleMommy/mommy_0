//
//  CommunityMentorController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityPersonListModel.h"
#import "CommonViewController.h"
#import "MommyRequest.h"

@protocol CommunityMentorDelegate <NSObject>

@optional

-(void) moveCommunityList:(NSString *)key value:(NSString *)value title:(NSString *)title;

@end

@interface CommunityMentorController : CommonViewController <CommunityPersonListModelDelegate>

@property (strong, nonatomic) CommunityPersonListModel *tableListController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) id<CommunityMentorDelegate> delegate;
@property (strong, nonatomic) UIViewController *noDataController;


@end
