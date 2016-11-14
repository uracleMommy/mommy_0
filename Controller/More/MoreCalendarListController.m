//
//  MoreCalendarListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreCalendarListController.h"
#import "GTMSessionFetcher.h"
#import "GTMSessionFetcherService.h"

#import <AppAuth/AppAuth.h>
#import <GTMAppAuth/GTMAppAuth.h>
#import <QuartzCore/QuartzCore.h>

/*! @brief The OIDC issuer from which the configuration will be discovered.
 */
static NSString *const kIssuer = @"https://accounts.google.com";

/*! @brief The OAuth client ID.
 @discussion For Google, register your client at
 https://console.developers.google.com/apis/credentials?project=_
 The client should be registered with the "iOS" type.
 */
static NSString *const kClientID = @"1008861736533-t5t3lb3m9u45o04usi4p1cuvm3nfh31a.apps.googleusercontent.com";

/*! @brief The OAuth redirect URI for the client @c kClientID.
 @discussion With Google, the scheme of the redirect URI is the reverse DNS notation of the
 client ID. This scheme must be registered as a scheme in the project's Info
 property list ("CFBundleURLTypes" plist key). Any path component will work, we use
 'oauthredirect' here to help disambiguate from any other use of this scheme.
 */
static NSString *const kRedirectURI =
@"com.googleusercontent.apps.1008861736533-t5t3lb3m9u45o04usi4p1cuvm3nfh31a:/oauthredirect";

/*! @brief @c NSCoding key for the authState property.
 */
static NSString *const kExampleAuthorizerKey = @"authorization";


@interface MoreCalendarListController () <OIDAuthStateChangeDelegate,
OIDAuthStateErrorDelegate>

@end

@implementation MoreCalendarListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEnvironmentCalendarModal = [[MoreEnvironmentCalendarModal alloc] init];
    _tableView.dataSource = _moreEnvironmentCalendarModal;
    _tableView.delegate = _moreEnvironmentCalendarModal;
    _moreEnvironmentCalendarModal.delegate = self;
    
    self.navigationItem.hidesBackButton = YES;
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
    self.service = [[GTLServiceCalendar alloc] init];
    self.service.authorizer = [GTMAppAuthFetcherAuthorization authorizationFromKeychainForName:kExampleAuthorizerKey];
//    [GTMAppAuthFetcherAuthorization authForGoogleFromKeychainForName:kKeychainItemName
//                                                          clientID:kClientID
//                                                      clientSecret:nil];
    
    
    [self loadState];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear:(BOOL)animated {
//    if (!self.service.authorizer.canAuthorize) {
//        // Not yet authorized, request authorization by pushing the login UI onto the UI stack.
//        [self presentViewController:[self createAuthController] animated:YES completion:nil];
//        
//    } else {
//        [self fetchEvents];
//    }
//}

// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

- (void) closeModal {
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*! @brief Saves the @c GTMAppAuthFetcherAuthorization to @c NSUSerDefaults.
 */
- (void)saveState {
    if (_authorization.canAuthorize) {
        [GTMAppAuthFetcherAuthorization saveAuthorization:_authorization
                                        toKeychainForName:kExampleAuthorizerKey];
    } else {
        [GTMAppAuthFetcherAuthorization removeAuthorizationFromKeychainForName:kExampleAuthorizerKey];
    }
}


/*! @brief Loads the @c GTMAppAuthFetcherAuthorization from @c NSUSerDefaults.
 */
- (void)loadState {
    GTMAppAuthFetcherAuthorization* authorization =
    [GTMAppAuthFetcherAuthorization authorizationFromKeychainForName:kExampleAuthorizerKey];
    [self setGtmAuthorization:authorization];
}

- (void)setGtmAuthorization:(GTMAppAuthFetcherAuthorization*)authorization {
    if ([_authorization isEqual:authorization]) {
        return;
    }
    _authorization = authorization;
    [self stateChanged];
}


- (void)stateChanged {
    [self saveState];
    [self updateUI];
}

/*! @brief Refreshes UI, typically called after the auth state changed.
 */
- (void)updateUI {
    //TODO 연동하기 안되있음 체크 로직 추가
    
//    
//    _userinfoButton.enabled = _authorization.canAuthorize;
//    _clearAuthStateButton.enabled = _authorization.canAuthorize;
//    // dynamically changes authorize button text depending on authorized state
    if (!_authorization.canAuthorize) {
//        [_authAutoButton setTitle:@"Authorize" forState:UIControlStateNormal];
//        [_authAutoButton setTitle:@"Authorize" forState:UIControlStateHighlighted];
    } else {
        [self fetchEvents];
//        [_authAutoButton setTitle:@"Re-authorize" forState:UIControlStateNormal];
//        [_authAutoButton setTitle:@"Re-authorize" forState:UIControlStateHighlighted];
    }
}

- (void)didChangeState:(OIDAuthState *)state {
    [self stateChanged];
}

- (void)authState:(OIDAuthState *)state didEncounterAuthorizationError:(NSError *)error {
    [self logMessage:@"Received authorization error: %@", error];
}

- (void)googleAuthLinkAction {
    NSURL *issuer = [NSURL URLWithString:kIssuer];
    NSURL *redirectURI = [NSURL URLWithString:kRedirectURI];
    
    [self logMessage:@"Fetching configuration for issuer: %@", issuer];
    
    // discovers endpoints
    [OIDAuthorizationService discoverServiceConfigurationForIssuer:issuer
                                                        completion:^(OIDServiceConfiguration *_Nullable configuration, NSError *_Nullable error) {
                                                            
                                                            if (!configuration) {
                                                                [self logMessage:@"Error retrieving discovery document: %@", [error localizedDescription]];
                                                                [self setGtmAuthorization:nil];
                                                                return;
                                                            }
                                                            
                                                            [self logMessage:@"Got configuration: %@", configuration];
                                                            
                                                            // builds authentication request
                                                            OIDAuthorizationRequest *request =
                                                            [[OIDAuthorizationRequest alloc] initWithConfiguration:configuration
                                                                                                          clientId:kClientID
                                                                                                            scopes:@[OIDScopeOpenID, OIDScopeProfile, kGTLAuthScopeCalendar]
                                                                                                       redirectURL:redirectURI
                                                                                                      responseType:OIDResponseTypeCode
                                                                                              additionalParameters:nil];
                                                            // performs authentication request
                                                            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                                            [self logMessage:@"Initiating authorization request with scope: %@", request.scope];
                                                            
                                                            appDelegate.currentAuthorizationFlow =
                                                            [OIDAuthState authStateByPresentingAuthorizationRequest:request
                                                                                           presentingViewController:self
                                                                                                           callback:^(OIDAuthState *_Nullable authState,
                                                                                                                      NSError *_Nullable error) {
                                                                                                               if (authState) {
                                                                                                                   GTMAppAuthFetcherAuthorization *authorization =
                                                                                                                   [[GTMAppAuthFetcherAuthorization alloc] initWithAuthState:authState];
                                                                                                                   
                                                                                                                   [self setGtmAuthorization:authorization];
                                                                                                                   [self logMessage:@"Got authorization tokens. Access token: %@",
                                                                                                                    authState.lastTokenResponse.accessToken];
                                                                                                               } else {
                                                                                                                   [self setGtmAuthorization:nil];
                                                                                                                   [self logMessage:@"Authorization error: %@", [error localizedDescription]];
                                                                                                               }
                                                                                                           }];
                                                        }];
}

- (IBAction)clearAuthState:(nullable id)sender {
    [self setGtmAuthorization:nil];
}

- (IBAction)clearLog:(nullable id)sender {
    _logTextView.text = @"";
}

- (IBAction)userinfo:(nullable id)sender {
    [self logMessage:@"Performing userinfo request"];
    
    // Creates a GTMSessionFetcherService with the authorization.
    // Normally you would save this service object and re-use it for all REST API calls.
    GTMSessionFetcherService *fetcherService = [[GTMSessionFetcherService alloc] init];
    fetcherService.authorizer = self.authorization;
    
    // Creates a fetcher for the API call.
    NSURL *userinfoEndpoint = [NSURL URLWithString:@"https://www.googleapis.com/oauth2/v3/userinfo"];
    GTMSessionFetcher *fetcher = [fetcherService fetcherWithURL:userinfoEndpoint];
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
        // Checks for an error.
        if (error) {
            // OIDOAuthTokenErrorDomain indicates an issue with the authorization.
            if ([error.domain isEqual:OIDOAuthTokenErrorDomain]) {
                [self setGtmAuthorization:nil];
                [self logMessage:@"Authorization error during token refresh, clearing state. %@", error];
                // Other errors are assumed transient.
            } else {
                [self logMessage:@"Transient error during token refresh. %@", error];
            }
            return;
        }
        
        // Parses the JSON response.
        NSError *jsonError = nil;
        id jsonDictionaryOrArray =
        [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        // JSON error.
        if (jsonError) {
            [self logMessage:@"JSON decoding error %@", jsonError];
            return;
        }
        
        // Success response!
        [self logMessage:@"Success: %@", jsonDictionaryOrArray];
    }];
}

/*! @brief Logs a message to stdout and the textfield.
 @param format The format string and arguments.
 */
- (void)logMessage:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    // gets message as string
    va_list argp;
    va_start(argp, format);
    NSString *log = [[NSString alloc] initWithFormat:format arguments:argp];
    va_end(argp);
    
    // outputs to stdout
    NSLog(@"%@", log);
    
    // appends to output log
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    _logTextView.text = [NSString stringWithFormat:@"%@%@%@: %@",
                         _logTextView.text,
                         ([_logTextView.text length] > 0) ? @"\n" : @"",
                         dateString,
                         log];
}

- (void)fetchEvents {
    
//    [self logMessage:@"Performing userinfo request"];
//    
//    // Creates a GTMSessionFetcherService with the authorization.
//    // Normally you would save this service object and re-use it for all REST API calls.
//    GTMSessionFetcherService *fetcherService = [[GTMSessionFetcherService alloc] init];
//    fetcherService.authorizer = self.authorization;
//    
//    // Creates a fetcher for the API call.
//    NSURL *userinfoEndpoint = [NSURL URLWithString:@"https://www.googleapis.com/calendar/v3"];
//    GTMSessionFetcher *fetcher = [fetcherService fetcherWithURL:userinfoEndpoint];
//    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
//        // Checks for an error.
//        if (error) {
//            // OIDOAuthTokenErrorDomain indicates an issue with the authorization.
//            if ([error.domain isEqual:OIDOAuthTokenErrorDomain]) {
//                [self setGtmAuthorization:nil];
//                [self logMessage:@"Authorization error during token refresh, clearing state. %@", error];
//                // Other errors are assumed transient.
//            } else {
//                [self logMessage:@"Transient error during token refresh. %@", error];
//            }
//            return;
//        }
//        
//        // Parses the JSON response.
//        NSError *jsonError = nil;
//        id jsonDictionaryOrArray =
//        [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//        
//        // JSON error.
//        if (jsonError) {
//            [self logMessage:@"JSON decoding error %@", jsonError];
//            return;
//        }
//        
//        // Success response!
//        [self logMessage:@"Success: %@", jsonDictionaryOrArray];
//    }];
    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsListWithCalendarId:@"primary"];
    query.maxResults = 10;
    query.timeMin = [GTLDateTime dateTimeWithDate:[NSDate date]
                                         timeZone:[NSTimeZone localTimeZone]];;
    query.singleEvents = YES;
    query.orderBy = kGTLCalendarOrderByStartTime;
    
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
}


- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
             finishedWithObject:(GTLCalendarEvents *)events
                          error:(NSError *)error {
    if (error == nil) {
        NSMutableString *eventString = [[NSMutableString alloc] init];
        if (events.items.count > 0) {
            [eventString appendString:@"Upcoming 10 events:\n"];
            for (GTLCalendarEvent *event in events) {
                GTLDateTime *start = event.start.dateTime ?: event.start.date;
                NSString *startString =
                [NSDateFormatter localizedStringFromDate:[start date]
                                               dateStyle:NSDateFormatterShortStyle
                                               timeStyle:NSDateFormatterShortStyle];
                [eventString appendFormat:@"%@ - %@\n", startString, event.summary];
            }
        } else {
            [eventString appendString:@"No upcoming events found."];
        }
//        self.output.text = eventString;
    } else {
//        [self showAlert:@"Error" message:error.localizedDescription];
    }
}

@end
