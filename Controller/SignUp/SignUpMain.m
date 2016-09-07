//
//  SignUpMain.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMain.h"

@interface SignUpMain ()

@end

@implementation SignUpMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMainScrollView"];

    [scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 680)];
    
    NSLog(@"%f %f", scrollViewContoller.view.frame.size.width, scrollViewContoller.view.frame.size.height);
    
    
    [_scrollView addSubview : scrollViewContoller.view];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 680);
    
    [_scrollView sizeToFit];
}

/*
#pragma mark - Navigationf

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) goBack{
    NSLog(@"PSH goBack");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
