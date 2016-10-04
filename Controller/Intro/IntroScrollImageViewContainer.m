//
//  IntroScrollImageViewContainer.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "IntroScrollImageViewContainer.h"

@interface IntroScrollImageViewContainer ()

@end

@implementation IntroScrollImageViewContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _introScrollImageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"scrollDeviceImageViewController"];
    [self.view addSubview:_introScrollImageViewController.view];
    
}

- (void) viewDidLayoutSubviews {
    
    _introScrollImageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) moveScrollView {
    
    NSLog(@"무브 스크롤 포인트 : %f", _parentScrollView.contentOffset.x);
    
    [_introScrollImageViewController moveScrollView:_parentScrollView];
}

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex {
    
    [_introScrollImageViewController bridgePageMoveCompleted:pageIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
