//
//  IntroPageContainerViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"
#import "IntroContentPageViewController.h"
#import "IntroFirstContentPageViewController.h"
#import "IntroSecondContentPageViewController.h"
#import "IntroThirdContentPageViewController.h"

@interface IntroPageContainerViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) UIViewController *selfParentViewController;

@property (assign) NSInteger currentIndex;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *imgFirstPage;

@property (weak, nonatomic) IBOutlet UIImageView *imgSecondPage;

@property (weak, nonatomic) IBOutlet UIImageView *imgThirdPage;

@end
