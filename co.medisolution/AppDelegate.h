//
//  AppDelegate.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "IndicatorViewController.h"
#import "SampleMainController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) SampleMainController *sampleMainController;

#pragma mark 인디케이터 관련
@property (strong, nonatomic) IndicatorViewController *indicatorView;
- (void) indicatorViewIn;
- (void) indicatorViewOut;

#pragma mark 스토리 보드 전환
- (void) go_story_board : (NSString *) storyboard_name;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UITabBarController *mainTabBar;

@end

