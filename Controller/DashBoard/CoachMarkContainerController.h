//
//  CoachMarkContainerController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachMarkContentController.h"
#import "CoachMarkFirstController.h"
#import "CoachMarkSecondController.h"
#import "CoachMarkThirdController.h"

@interface CoachMarkContainerController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (assign) NSInteger currentIndex;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
