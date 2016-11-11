//
//  MoreCalendarListController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreCalendarListController.h"

@interface MoreCalendarListController ()

@end

@implementation MoreCalendarListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEnvironmentCalendarModal = [[MoreEnvironmentCalendarModal alloc] init];
    _tableView.dataSource = _moreEnvironmentCalendarModal;
    _tableView.delegate = _moreEnvironmentCalendarModal;
    
    self.navigationItem.hidesBackButton = YES;
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

- (void) closeModal {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
