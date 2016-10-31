//
//  IntroViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroPageContainerViewController.h"
#import "IntroDeviceViewController.h"
#import "CommonViewController.h"

@interface IntroViewController : CommonViewController

- (void) scrollView : (UIScrollView *) scrollView;

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex;

@property (strong, nonatomic) IntroDeviceViewController *introDeviceViewController;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberShip;

- (IBAction)goLogin:(id)sender;

- (IBAction)goMemberShip:(id)sender;

@end
