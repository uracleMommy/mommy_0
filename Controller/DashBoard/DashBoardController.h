//
//  DashBoardController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MessageListController.h"
#import "MainSliderViewContainerController.h"
#import "MainInfoContainerViewController.h"
#import "CoachMarkContainerController.h"

@protocol DashBoardControllerDelegate;

@interface DashBoardController : CommonViewController <MainSliderViewContainerDelegate, MainInfoContainerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *firstLedBox;

@property (weak, nonatomic) IBOutlet UIView *secondLedBox;

@property (weak, nonatomic) IBOutlet UIView *thirdLedBox;

@property (strong, nonatomic) NSArray *scrollViewArray;

@property (strong, nonatomic) MessageListController *messageListController;

@property (strong, nonatomic) id<DashBoardControllerDelegate> delegate;

@property (strong, nonatomic) CoachMarkContainerController *coachMarkContainerController;

- (IBAction)WeekProgramAction:(id)sender;

- (IBAction)MessagePopupAction:(id)sender;

- (IBAction)SingleImageView:(id)sender;

- (IBAction)MultiImageView:(id)sender;

- (IBAction)NoticeView:(id)sender;

- (IBAction)MessageModal:(id)sender;

- (void) setMainSliderPage : (NSInteger) pageIndex;

@property (strong, nonatomic) NSArray *programList;

@property (strong, nonatomic) NSDictionary *mainList;

@property (strong, nonatomic) NSDictionary *dashboardDic;

@property (strong, nonatomic) MainSliderViewContainerController *mainSliderViewContainerController;

@property (strong, nonatomic) MainInfoContainerViewController *mainInfoContainerViewController;

@property (strong, nonatomic) NSString *weightCode;

@property (strong, nonatomic) NSString *healthProgramSeq;

@property (strong, nonatomic) NSString *sportsProgramSeq;

@property (strong, nonatomic) NSString *nutritionProgramSeq;

@end

@protocol DashBoardControllerDelegate <NSObject>

@optional

- (void) presentMessage;

- (void) presentWeight;


@end
