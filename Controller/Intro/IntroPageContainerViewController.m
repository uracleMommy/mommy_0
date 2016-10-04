
//
//  IntroPageContainerViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "IntroPageContainerViewController.h"

@interface IntroPageContainerViewController ()

@end

@implementation IntroPageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _introViewController = (IntroViewController *)[self parentViewController];
    
    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    IntroContentPageViewController  *startViewControlle = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startViewControlle];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    
//    [self.view addSubview:_pageViewController.view];
    [_containerView addSubview:_pageViewController.view];
    
    [_pageViewController didMoveToParentViewController:self];
    
    _currentIndex = 0;
    
    for (UIView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
}

- (void) viewDidLayoutSubviews {
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
}

- (IntroContentPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 3) {
        
        return nil;
    }
    
    IntroContentPageViewController *pageContentViewController;
    
    if (index == 0) {
        
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"firstContentController"];
        
    }
    else if (index == 1) {
        
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondContentController"];
        
    }
    else {
        
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"thirdContentController"];
        
    }
    
    pageContentViewController.pageIndex = index;
    _currentIndex = index;
    
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((IntroContentPageViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((IntroContentPageViewController*) viewController).pageIndex;
    
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
    
    IntroContentPageViewController *viewController;
    
    if (completed) {
        
        viewController = [pageViewController.viewControllers lastObject];
        
        if (viewController.pageIndex == 0) {
            
            _imgFirstPage.hidden = NO;
            _imgSecondPage.hidden = YES;
            _imgThirdPage.hidden = YES;
        }
        else if (viewController.pageIndex == 1) {
            
            _imgFirstPage.hidden = YES;
            _imgSecondPage.hidden = NO;
            _imgThirdPage.hidden = YES;
        }
        else if (viewController.pageIndex == 2) {
            
            _imgFirstPage.hidden = YES;
            _imgSecondPage.hidden = YES;
            _imgThirdPage.hidden = NO;
        }
        
        IntroViewController *introViewController = (IntroViewController *)_selfParentViewController;
        [introViewController bridgePageMoveCompleted:viewController.pageIndex];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    IntroViewController *introViewController = (IntroViewController *)_selfParentViewController;
    
    [introViewController scrollView:scrollView];
    
    NSLog(@"%f", scrollView.contentOffset.x);
}

@end
