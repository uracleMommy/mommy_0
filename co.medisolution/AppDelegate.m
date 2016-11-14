//
//  AppDelegate.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "AppDelegate.h"
#import "AppAuth.h"
//#import <LifesenseBluetooth/PlusOTAMananger.h>
//#import <LifesenseBluetooth/LSBLEDeviceManager.h>


@interface AppDelegate ()

@end

@implementation AppDelegate
static NSString * const kClientID =
@"1008861736533-u7jvn3hgunrm85lafb0otio26758ps30.apps.googleusercontent.com";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    _sampleMainController = [[SampleMainController alloc] initWithNibName:@"SampleMainController" bundle:nil];
//    self.window.rootViewController = _sampleMainController;
    
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if(ver >= 8 && ver<9)
    {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
        }
    }else if (ver >=9){
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        
    }
    else{
        //iOS6 and iOS7 specific code
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark 인디케이터 관련

- (void) indicatorViewIn {
    
    if (!_indicatorView) {
        _indicatorView = [[IndicatorViewController alloc] initWithNibName:@"IndicatorViewController" bundle:nil];
        _indicatorView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    [self.window addSubview:_indicatorView.view];
    [_indicatorView startIndicator];
}

- (void) indicatorViewOut {
    [_indicatorView stopIndicator];
    [_indicatorView.view removeFromSuperview];
}


#pragma mark 스토리 보드 전한

- (void) go_story_board : (NSString *) storyboard_name {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    // Set root view controller and make windows visible
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

#pragma mark 1:1 전문가 상담 버튼뷰 관련

#pragma 버튼뷰 ADD
- (void) buttonViewIn {
    
    if (!_moreProfessionalButtonViewController) {
        
        _moreProfessionalButtonViewController = [[MoreProfessionalButtonViewController alloc] initWithNibName:@"MoreProfessionalButtonViewController" bundle:nil];
        _moreProfessionalButtonViewController.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    [self.window addSubview:_moreProfessionalButtonViewController.view];
}

#pragma 버튼뷰 REMOVE
- (void) buttonViewOut {
    
    [_moreProfessionalButtonViewController.view removeFromSuperview];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "kr.co_medisolution" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"co_medisolution" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"co_medisolution.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark 푸쉬 관련
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
    NSString *aaa = [[NSString alloc] initWithData:devToken encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", aaa);
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@" 디바이스 토큰 : %@", deviceToken);
    [GlobalData sharedGlobalData].deviceToken = deviceToken;
    
    //#if !TARGET_IPHONE_SIMULATOR
    //
    //    // Get Bundle Info for Remote Registration (handy if you have more than one app)
    //    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    //    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    //
    ////    [[UIApplication sharedApplication] currentUserNotificationSettings
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //    // Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
    //    NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    //
    //    // Set the defaults to disabled unless we find otherwise...
    //    NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
    //    NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
    //    NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";
    //
    //    // Get the users Device Model, Display Name, Unique ID, Token & Version Number
    //    UIDevice *dev = [UIDevice currentDevice];
    //    NSString *deviceUuid;
    //    if ([dev respondsToSelector:@selector(uniqueIdentifier)])
    //        deviceUuid = dev.uniqueIdentifier;
    //    else {
    //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //        id uuid = [defaults objectForKey:@"deviceUuid"];
    //        if (uuid)
    //            deviceUuid = (NSString *)uuid;
    //        else {
    //            CFStringRef cfUuid = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
    //            deviceUuid = (NSString *)cfUuid;
    //            CFRelease(cfUuid);
    //            [defaults setObject:deviceUuid forKey:@"deviceUuid"];
    //        }
    //    }
    //    NSString *deviceName = dev.name;
    //    NSString *deviceModel = dev.model;
    //    NSString *deviceSystemVersion = dev.systemVersion;
    //
    //    // Prepare the Device Token for Registration (remove spaces and < >)
    //    NSString *deviceToken = [[[[devToken description]
    //                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
    //                              stringByReplacingOccurrencesOfString:@">" withString:@""]
    //                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    //
    //    // Build URL String for Registration
    //    // !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
    //    // !!! SAMPLE: "secure.awesomeapp.com"
    //    NSString *host = @"www.mywebsite.com";
    //
    //    // !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED
    //    // !!! ( MUST START WITH / AND END WITH ? ).
    //    // !!! SAMPLE: "/path/to/apns.php?"
    //    NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
    //
    //    // Register the Device Data
    //    // !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
    //    NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //    [NSURLConnection sendAsynchronousRequest:request
    //                                       queue:[NSOperationQueue mainQueue]
    //                           completionHandler:^(NSURLResponse *urlR, NSData *returnData, NSError *e) {
    //                               NSLog(@"Return Data: %@", returnData);
    //
    //                           }];
    //
    //    NSLog(@"Register URL: %@", url);
    //
    //#endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
#if !TARGET_IPHONE_SIMULATOR
    
    NSLog(@"Error in registration. Error: %@", error);
    
#endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
}



/*! @brief Handles inbound URLs. Checks if the URL matches the redirect URI for a pending
 AppAuth authorization request.
 */
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    // Sends the URL to the current authorization flow (if any) which will process it if it relates to
    // an authorization response.
    if ([_currentAuthorizationFlow resumeAuthorizationFlowWithURL:url]) {
        _currentAuthorizationFlow = nil;
        return YES;
    }
    
    // Your additional URL handling (if any) goes here.
    
    return NO;
}

/*! @brief Forwards inbound URLs for iOS 8.x and below to @c application:openURL:options:.
 @discussion When you drop support for versions of iOS earlier than 9.0, you can delete this
 method. NB. this implementation doesn't forward the sourceApplication or annotations. If you
 need these, then you may want @c application:openURL:options to call this method instead.
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [self application:application
                     openURL:url
                     options:@{}];
}


@end
