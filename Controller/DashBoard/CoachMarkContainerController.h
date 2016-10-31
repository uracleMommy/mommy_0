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

@property (weak, nonatomic) IBOutlet UIImageView *imgFirstPage;

@property (weak, nonatomic) IBOutlet UIImageView *imgSecondPage;

@property (weak, nonatomic) IBOutlet UIImageView *imgThirdPage;

@property (weak, nonatomic) IBOutlet UIButton *btnStart;

@property (weak, nonatomic) IBOutlet UIView *underLine;

- (IBAction) goStart:(id) sender;

@end
