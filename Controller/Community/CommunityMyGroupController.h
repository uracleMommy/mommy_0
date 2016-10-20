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
-(void) moveCommunityList:(NSString *)key value:(NSString *)value title:(NSString *)title;

@end

@interface CommunityMyGroupController : CommonViewController

@property (strong, nonatomic) id<CommunityMyGroupDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *groupButton01;
@property (weak, nonatomic) IBOutlet UIButton *groupButton02;
@property (weak, nonatomic) IBOutlet UIButton *groupButton03;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel01;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel02;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel03;
@property (strong, nonatomic) NSMutableArray *groupKeyArr;
@property (strong, nonatomic) NSMutableArray *groupValueArr;
@property (strong, nonatomic) NSMutableArray *groupTitleArr;


- (IBAction)moveCommunityList:(id)sender;

@end
