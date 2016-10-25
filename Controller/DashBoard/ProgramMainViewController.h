//
//  ProgramMainViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"

@interface ProgramMainViewController : CommonViewController

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *programSegment;

@property (strong, nonatomic) NSString *weightStatusCode;

- (IBAction)weekProgramListAction:(id)sender;

@property (assign, nonatomic) WeekProgramEnabledKind weekProgramEnabledKind;

@property (strong, nonatomic) NSArray *programList;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
