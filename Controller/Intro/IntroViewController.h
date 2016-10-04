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

@interface IntroViewController : UIViewController

- (void) scrollView : (UIScrollView *) scrollView;

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex;

@property (strong, nonatomic) IntroDeviceViewController *introDeviceViewController;

@end
