//
//  CommunityMainController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"
#import "CommunityMyGroupController.h"
#import "CommunityMentorController.h"

@interface CommunityMainController : UIViewController<DZNSegmentedControlDelegate, CommunityMyGroupDelegate, CommunityMentorDelegate>

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *tabView;
@property (strong, nonatomic) CommunityMyGroupController *myGroupViewController;
@property (strong, nonatomic) CommunityMentorController *mentorViewController;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
