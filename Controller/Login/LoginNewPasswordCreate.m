//
//  LoginNewPasswordCreate.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginNewPasswordCreate.h"

@interface LoginNewPasswordCreate ()

@end

@implementation LoginNewPasswordCreate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //close Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    //    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, -15, 0);
    [backButtonView addSubview:backBtn];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.rightBarButtonItem = backButton;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
