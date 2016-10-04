//
//  IntroDeviceViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "IntroDeviceViewController.h"

@interface IntroDeviceViewController ()

@end

@implementation IntroDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.0f];
    
//    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DevicePageViewController"];
//    _pageViewController.dataSource = self;
//    _pageViewController.delegate = self;
//    
//    IntroDeviceImageViewController  *startViewControlle = [self viewControllerAtIndex:0];
//    NSArray *viewControllers = @[startViewControlle];
//    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//    
//
//    
//    [self addChildViewController:_pageViewController];
//    [self.view insertSubview:_pageViewController.view belowSubview:_deviceImage];
//    
//    [_pageViewController didMoveToParentViewController:self];
//    
//    _currentIndex = 0;
//    
//    for (UIView *view in self.pageViewController.view.subviews) {
//        if ([view isKindOfClass:[UIScrollView class]]) {
//            _scrollView = (UIScrollView *)view;
//            [(UIScrollView *)view setDelegate:self];
//        }
//    }
    
}

- (void) viewDidLayoutSubviews {
    
    _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    NSLog(@"%f %f", self.view.frame.size.width, self.view.frame.size.height);
}

- (IntroDeviceImageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= 3) {
        
        return nil;
    }
    
    IntroDeviceImageViewController *introDeviceImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"deviceImageViewController"];
    
    
    introDeviceImageViewController.pageIndex = index;
    introDeviceImageViewController.deviceImageView.image = [UIImage imageNamed:@"entry_img_device_01"];
    _currentIndex = index;
    
    
    return introDeviceImageViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((IntroDeviceImageViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((IntroDeviceImageViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@" 움직여야할 스크롤 포인트 : %f", scrollView.contentOffset.x);
    NSLog(@" 움직여야할 스크롤 포인트 : %f", scrollView.contentOffset.y);
}

- (void) moveScrollView {
//    _parentScrollView.contentOffset.x / _scrollView.contentOffset
    
//    NSLog(@"무브 스크롤 포인트 : %f", _parentScrollView.contentOffset.x);
    _introScrollImageViewContainer.parentScrollView = _parentScrollView;
    [_introScrollImageViewContainer moveScrollView];
}

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex {
    
    [_introScrollImageViewContainer bridgePageMoveCompleted:pageIndex];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goImageScrollViewContainer"]) {
        
        _introScrollImageViewContainer = (IntroScrollImageViewContainer *)segue.destinationViewController;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
