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

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark 인디케이터 관련
@property (strong, nonatomic) IndicatorViewController *indicatorView;
- (void) indicatorViewIn;
- (void) indicatorViewOut;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UITabBarController *mainTabBar;

@end

