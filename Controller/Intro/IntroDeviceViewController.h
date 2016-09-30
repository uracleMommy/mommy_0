//
//  IntroDeviceViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroDeviceImageViewController.h"
#import "IntroScrollImageViewController.h"

@interface IntroDeviceViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *deviceImage;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (assign) NSUInteger currentIndex;

@property (strong, nonatomic) UIScrollView *parentScrollView;

@property (strong, nonatomic) IntroScrollImageViewController *introScrollImageViewController;

- (void) moveScrollView;

@end
