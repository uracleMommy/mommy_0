//
//  MainTabbarController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.tabBar.backgroundColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    
    //self.tabBar.backgroundColor = [UIColor redColor];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0f];
    
    // 대시보드 루트 컨트롤러 할당
    UIStoryboard *dashBoardStoryboard = [UIStoryboard storyboardWithName:@"DashBoard" bundle:nil];
    _firstTabViewController = [dashBoardStoryboard instantiateInitialViewController];
    
    UINavigationController *firstController = (UINavigationController *)self.viewControllers[0];
    [firstController setViewControllers:@[_firstTabViewController]];
    
    // 다이어리 루트 컨트롤러 할당
    UIStoryboard *diaryBoardStoryboard = [UIStoryboard storyboardWithName:@"Diary" bundle:nil];
    
    _secondTabViewController = [diaryBoardStoryboard instantiateInitialViewController];
    
    UINavigationController *secondController = (UINavigationController *)self.viewControllers[1];
    [secondController setViewControllers:@[_secondTabViewController]];
    
    
    // 커뮤니티 루트 컨트롤러 할당
    UIStoryboard *communityStoryboard = [UIStoryboard storyboardWithName:@"Community" bundle:nil];
    _thirdTabViewController = [communityStoryboard instantiateInitialViewController];
    
    UINavigationController *thirdController = (UINavigationController *)self.viewControllers[2];
    [thirdController setViewControllers:@[_thirdTabViewController]];

    
    // 더보기 루트 컨트롤러 할당
    UIStoryboard *moreStoryboard = [UIStoryboard storyboardWithName:@"More" bundle:nil];
    _fourthTabViewController = [moreStoryboard instantiateInitialViewController];
    
    UINavigationController *fourthController = (UINavigationController *)self.viewControllers[3];
    [fourthController setViewControllers:@[_fourthTabViewController]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
