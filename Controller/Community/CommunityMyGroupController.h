//
//  CommunityMyGroupController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommunityMyGroupDelegate <NSObject>

@optional
-(void) moveCommunityList;

@end

@interface CommunityMyGroupController : UIViewController
@property (strong, nonatomic) id<CommunityMyGroupDelegate> delegate;

- (IBAction)moveCommunityList:(id)sender;

@end
