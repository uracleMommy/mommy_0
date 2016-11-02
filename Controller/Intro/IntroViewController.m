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
    
    _btnLogin.layer.borderColor = [[UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f] CGColor];
    _btnLogin.layer.borderWidth = 1.0f;
    _btnLogin.layer.cornerRadius = 18;
    
    _btnMemberShip.layer.borderColor = [[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f] CGColor];
    _btnMemberShip.layer.borderWidth = 1.0f;
    _btnMemberShip.layer.cornerRadius = 18;
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

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex {
    
    [_introDeviceViewController bridgePageMoveCompleted:pageIndex];
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

- (IBAction)goLogin:(id)sender {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:[NSBundle mainBundle]];
//    
//    UIViewController *viewController = [storyboard instantiateInitialViewController];
//    
//    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    appDelegate.window.rootViewController = viewController;
//    
//    [appDelegate.window makeKeyAndVisible];

    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:[NSBundle mainBundle]];
//    UIViewController *vc = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpMommyInfoController"];
//    
//    [self presentViewController:vc animated:YES completion:nil];
    
    UIStoryboard *mainTabBarStoryboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:nil];
    UINavigationController *mainTabBarNavigationController = (UINavigationController *)[mainTabBarStoryboard instantiateViewControllerWithIdentifier:@"MembershipLoginNavigation"];
    
    [self presentViewController:mainTabBarNavigationController animated:YES completion:nil];
    
//    if (screenRect.size.width <= 320) {
//        
//        // 3.5
//        if (screenRect.size.height <= 480) {
//            vc = (ParLoginController *)[storyboard instantiateViewControllerWithIdentifier:@"login_3.5"];
//        }
//        else {
//            vc = (ParLoginController *)[storyboard instantiateViewControllerWithIdentifier:@"login_4.0"];
//        }
//    }
//    else if (screenRect.size.width <= 375) {
//        vc = (ParLoginController *)[storyboard instantiateViewControllerWithIdentifier:@"login_4.7"];
//    }
//    else {
//        vc = (ParLoginController *)[storyboard instantiateViewControllerWithIdentifier:@"login_5.5"];
//    }
//    
//    // Set root view controller and make windows visible
//    self.window.rootViewController = vc;
//    [self.window makeKeyAndVisible];
}

- (IBAction)goMemberShip:(id)sender {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:[NSBundle mainBundle]];
//    
//    UIViewController *viewController = [storyboard instantiateInitialViewController];
//    
//    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    appDelegate.window.rootViewController = viewController;
//    
//    [appDelegate.window makeKeyAndVisible];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:[NSBundle mainBundle]];
    UINavigationController *vc = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpMain"];
    
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
