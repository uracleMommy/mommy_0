//
//  SignUpAuthController.m
//  co.medisolution
//
//  Created by uracle on 2016. 11. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpAuthController.h"

@interface SignUpAuthController ()

@end

@implementation SignUpAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backButton;
    
    self.navigationItem.hidesBackButton = YES;
    
    
    _webView.delegate = self;
    for (id subview in _webView.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
    
//    if(_type == AuthText1){
        // html 바인딩
        NSString *path = [NSString stringWithFormat:@"%@/html/term/term%d.html", _mainDomain, _type];
        NSURL *url = [[NSURL alloc] initWithString:path];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [_webView loadRequest:request];
//    }else{
//    }
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

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
