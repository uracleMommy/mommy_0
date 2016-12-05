//
//  CoachMarkContainerController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CoachMarkContainerController.h"

@interface CoachMarkContainerController ()

@end

@implementation CoachMarkContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.8f];
    
    _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachPageViewController"];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    CoachMarkContentController *startViewControlle = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startViewControlle];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    
    [_pageViewController didMoveToParentViewController:self];
    
    [self.view addSubview:_pageViewController.view];
    
    _currentIndex = 0;
    
    [self.view bringSubviewToFront:_btnStart];
}


- (CoachMarkContentController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= 3) {
        
        return nil;
    }
    
    CoachMarkContentController *pageContentViewController;
    
    if (index == 0) {
        
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachFirstViewController"];
        
    }
    else if (index == 1) {
        
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachSecondViewController"];
        
    }
    else {
        
        pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachThirdViewController"];
        
    }
    
    pageContentViewController.pageIndex = index;
    _currentIndex = index;
    
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((CoachMarkContentController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((CoachMarkContentController*) viewController).pageIndex;
    
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
    
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    CoachMarkContentController *viewController;
    
    if (completed) {
        
        viewController = [pageViewController.viewControllers lastObject];
        
        if (viewController.pageIndex == 0) {
            
            _imgFirstPage.hidden = NO;
            _imgSecondPage.hidden = YES;
            _imgThirdPage.hidden = YES;
            _btnStart.hidden = YES;
            _underLine.hidden = YES;
        }
        else if (viewController.pageIndex == 1) {
            
            _imgFirstPage.hidden = YES;
            _imgSecondPage.hidden = NO;
            _imgThirdPage.hidden = YES;
            _btnStart.hidden = YES;
            _underLine.hidden = YES;
        }
        else if (viewController.pageIndex == 2) {
            
            _imgFirstPage.hidden = YES;
            _imgSecondPage.hidden = YES;
            _imgThirdPage.hidden = NO;
            _btnStart.hidden = NO;
            _underLine.hidden = NO;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goStart:(id)sender {
    [self.view removeFromSuperview];
    [_delegate startDashBoard];
}

@end
