//
//  IntroViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollView : (UIScrollView *) scrollView {
    
    NSLog(@" 인트로 루트에서 받은 스크롤뷰 오프셋 %f", scrollView.contentOffset.x);
    
    _introDeviceViewController.parentScrollView = scrollView;
    [_introDeviceViewController moveScrollView];
//    [_introDeviceViewController moveScrollView:scrollView];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"textContainerSegue"]) {
        
        IntroPageContainerViewController *introPageContainerViewController = (IntroPageContainerViewController *)segue.destinationViewController;
        introPageContainerViewController.selfParentViewController = self;
    }
    else if ([segue.identifier isEqualToString:@"imageContainerView"]) {
        
        _introDeviceViewController = (IntroDeviceViewController *)segue.destinationViewController;
        
    }
}

@end
