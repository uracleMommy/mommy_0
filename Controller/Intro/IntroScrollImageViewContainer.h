//
//  IntroScrollImageViewContainer.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroScrollImageViewController.h"

@interface IntroScrollImageViewContainer : UIViewController

@property (strong, nonatomic) IntroScrollImageViewController *introScrollImageViewController;

@property (strong, nonatomic) UIScrollView *parentScrollView;

- (void) moveScrollView;

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex;

@end
