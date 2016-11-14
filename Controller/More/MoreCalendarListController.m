//
//  MoreCalendarListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreCalendarListController.h"

static NSString *const kIssuer = @"https://accounts.google.com";
static NSString *const kClientID = @"1008861736533-t5t3lb3m9u45o04usi4p1cuvm3nfh31a.apps.googleusercontent.com";
static NSString *const kRedirectURI =
@"com.googleusercontent.apps.1008861736533-t5t3lb3m9u45o04usi4p1cuvm3nfh31a:/oauthredirect";
static NSString *const kExampleAuthorizerKey = @"authorization";


@interface MoreCalendarListController ()

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
//    self.service = [[GTLServiceCalendar alloc] init];
    
    [self loadState];
    //    [self updateUI];
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

- (void)saveState {
    if (_authorization.canAuthorize) {
        [GTMAppAuthFetcherAuthorization saveAuthorization:_authorization
                                        toKeychainForName:kExampleAuthorizerKey];
    } else {
        [GTMAppAuthFetcherAuthorization removeAuthorizationFromKeychainForName:kExampleAuthorizerKey];
    }
}

- (void)loadState {
    GTMAppAuthFetcherAuthorization* authorization =
    [GTMAppAuthFetcherAuthorization authorizationFromKeychainForName:kExampleAuthorizerKey];
    [self setGtmAuthorization:authorization];
}

- (void)setGtmAuthorization:(GTMAppAuthFetcherAuthorization*)authorization {
    if ([_authorization isEqual:authorization]) {
        [self updateUI];
        return;
    }
    _authorization = authorization;
    [self stateChanged];
}


- (void)stateChanged {
    [self saveState];
    [self updateUI];
}

- (void)updateUI {
    if (!_authorization.canAuthorize) {
        _moreEnvironmentCalendarModal.authFlag = NO;
        _moreEnvironmentCalendarModal.accountText = @"www.google.com";
        [_tableView reloadData];
    } else {
        _moreEnvironmentCalendarModal.authFlag = YES;
        _moreEnvironmentCalendarModal.accountText = @"";
        [_tableView reloadData];
//        [self fetchEvents];
    }
}

- (void)didChangeState:(OIDAuthState *)state {
    [self stateChanged];
}

- (void)authState:(OIDAuthState *)state didEncounterAuthorizationError:(NSError *)error {
    NSLog(@"Received authorization error: %@", error);
}

- (void)googleAuthLinkAction {
    
    if (!_authorization.canAuthorize) {
        
        NSURL *issuer = [NSURL URLWithString:kIssuer];
        NSURL *redirectURI = [NSURL URLWithString:kRedirectURI];
        
        NSLog(@"Fetching configuration for issuer: %@", issuer);
        
        // discovers endpoints
        [OIDAuthorizationService discoverServiceConfigurationForIssuer:issuer
                                                            completion:^(OIDServiceConfiguration *_Nullable configuration, NSError *_Nullable error) {
                                                                
                                                                if (!configuration) {
                                                                    NSLog(@"Error retrieving discovery document: %@", [error localizedDescription]);
                                                                    [self setGtmAuthorization:nil];
                                                                    return;
                                                                }
                                                                NSLog(@"Got configuration: %@", configuration);
                                                                
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
                                                                NSLog(@"Initiating authorization request with scope: %@", request.scope);
                                                                
                                                                appDelegate.currentAuthorizationFlow =
                                                                [OIDAuthState authStateByPresentingAuthorizationRequest:request
                                                                                               presentingViewController:self
                                                                                                               callback:^(OIDAuthState *_Nullable authState,
                                                                                                                          NSError *_Nullable error) {
                                                                                                                   if (authState) {
                                                                                                                       GTMAppAuthFetcherAuthorization *authorization =
                                                                                                                       [[GTMAppAuthFetcherAuthorization alloc] initWithAuthState:authState];
                                                                                                                       
                                                                                                                       [self setGtmAuthorization:authorization];
                                                                                                                       NSLog(@"Got authorization tokens. Access token: %@",
                                                                                                                             authState.lastTokenResponse.accessToken);
                                                                                                                   } else {
                                                                                                                       [self setGtmAuthorization:nil];
                                                                                                                       NSLog(@"Authorization error: %@", [error localizedDescription]);
                                                                                                                   }
                                                                                                               }];
                                                            }];
    } else {
        [self clearAuthState];
    }
}

- (void)clearAuthState {
    //연결 해지 버튼 클릭
    //    [popup title : 알림, 내용 : 캘린더연결을해지하시겠습니까? 버튼- 취소, 연결해지];
    [self setGtmAuthorization:nil];
}

//- (void)fetchEvents {
//    GTLQueryCalendar *query = [GTLQueryCalendar queryForEventsListWithCalendarId:@"primary"];
//    query.maxResults = 10;
//    query.timeMin = [GTLDateTime dateTimeWithDate:[NSDate date]
//                                         timeZone:[NSTimeZone localTimeZone]];;
//    query.singleEvents = YES;
//    query.orderBy = kGTLCalendarOrderByStartTime;
//    
//    [self.service executeQuery:query
//                      delegate:self
//             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
//}
//
//
//- (void)displayResultWithTicket:(GTLServiceTicket *)ticket
//             finishedWithObject:(GTLCalendarEvents *)events
//                          error:(NSError *)error {
//    if (error == nil) {
//        NSMutableString *eventString = [[NSMutableString alloc] init];
//        if (events.items.count > 0) {
//            [eventString appendString:@"Upcoming 10 events:\n"];
//            for (GTLCalendarEvent *event in events) {
//                GTLDateTime *start = event.start.dateTime ?: event.start.date;
//                NSString *startString =
//                [NSDateFormatter localizedStringFromDate:[start date]
//                                               dateStyle:NSDateFormatterShortStyle
//                                               timeStyle:NSDateFormatterShortStyle];
//                [eventString appendFormat:@"%@ - %@\n", startString, event.summary];
//            }
//            
//            NSLog(@"%@", eventString);
//        } else {
//            [eventString appendString:@"No upcoming events found."];
//        }
//    } else {
//        NSLog(@"Error %@", error.localizedDescription);
//    }
//}
//
@end
