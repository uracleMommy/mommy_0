//
//  AppDelegate.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GlobalData.h"
#import "IndicatorViewController.h"
#import "SampleMainController.h"
#import "MoreProfessionalButtonViewController.h"


@protocol OIDAuthorizationFlowSession;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark 코어데이터 관련
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) SampleMainController *sampleMainController;

#pragma mark 인디케이터 관련
@property (strong, nonatomic) IndicatorViewController *indicatorView;
- (void) indicatorViewIn;
- (void) indicatorViewOut;

#pragma mark 스토리 보드 전환
- (void) go_story_board : (NSString *) storyboard_name;


#pragma mark 탭바관련
@property (strong, nonatomic) UITabBarController *mainTabBar;

#pragma mark 1:1 전문가 상담 버튼뷰 관련
@property (strong, nonatomic) MoreProfessionalButtonViewController *moreProfessionalButtonViewController;



#pragma mark google auth 관련
@property(nonatomic, strong, nullable) id<OIDAuthorizationFlowSession> currentAuthorizationFlow;


@end

