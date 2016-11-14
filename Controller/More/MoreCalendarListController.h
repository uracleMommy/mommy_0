//
//  MoreCalendarListController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEnvironmentModel.h"
#import "GTMAppAuth.h"
#import "GTLCalendar.h"

@interface MoreCalendarListController : CommonViewController <MoreEnvironmentListModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MoreEnvironmentCalendarModal *moreEnvironmentCalendarModal;

@property (nonatomic, strong) GTLServiceCalendar *service;
@property(nullable) IBOutlet UIButton *authAutoButton;
@property(nullable) IBOutlet UIButton *userinfoButton;
@property(nullable) IBOutlet UIButton *clearAuthStateButton;
@property(nullable) IBOutlet UITextView *logTextView;

/*! @brief The authorization state.
 */
@property(nonatomic, nullable) GTMAppAuthFetcherAuthorization *authorization;

/*! @brief Authorization code flow using @c OIDAuthState automatic code exchanges.
 @param sender IBAction sender.
 */
- (IBAction)authWithAutoCodeExchange:(nullable id)sender;

/*! @brief Performs a Userinfo API call using @c OIDAuthState.withFreshTokensPerformAction.
 @param sender IBAction sender.
 */
- (IBAction)userinfo:(nullable id)sender;

/*! @brief Nils the @c OIDAuthState object.
 @param sender IBAction sender.
 */
- (IBAction)clearAuthState:(nullable id)sender;

/*! @brief Clears the UI log.
 @param sender IBAction sender.
 */
- (IBAction)clearLog:(nullable id)sender;


@end
