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

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // 아이폰 4s 이하
    if (screenRect.size.width == 320 && screenRect.size.height == 480) {
        
        _containerViewWidth.constant = 132;
        _containerViewHeight.constant = 220;
    }
    // 아이폰 5/5s
    else if(screenRect.size.width == 320) {
        
        _containerViewWidth.constant = 132;
        _containerViewHeight.constant = 220;
    }
    // 아이폰 6/6s/7
    else if (screenRect.size.width == 375) {
        
        // width : 184 / height : 304
        _containerViewWidth.constant = 184;
        _containerViewHeight.constant = 304;
    }
    // 아이폰 6 Plus/6s Puls/7 Plus
    else if (screenRect.size.width == 414) {
        
        _containerViewWidth.constant = 208;
        _containerViewHeight.constant = 346;
    }
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
