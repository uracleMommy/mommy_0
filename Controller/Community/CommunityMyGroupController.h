//
//  CommunityMyGroupController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@protocol CommunityMyGroupDelegate <NSObject>

@optional
-(void) moveCommunityList;

@end

@interface CommunityMyGroupController : CommonViewController

@property (strong, nonatomic) id<CommunityMyGroupDelegate> delegate;

- (IBAction)moveCommunityList:(id)sender;

@end
