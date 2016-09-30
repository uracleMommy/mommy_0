//
//  IntroScrollImageViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "IntroScrollImageViewController.h"

@interface IntroScrollImageViewController ()

@end

@implementation IntroScrollImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageContainerView = [[UIView alloc] init];
    [_scrollView addSubview:_imageContainerView];
    
    _firstImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entry_img_01"]];
    _secondImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entry_img_02"]];
    _thirdImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entry_img_03"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height)];
    [_imageContainerView setFrame:CGRectMake(0, 0, _scrollView.frame.size.width * 3, _scrollView.frame.size.height)];
    
    NSLog(@"스크롤뷰 사이즈 : %f %f", _scrollView.frame.size.width, _scrollView.frame.size.height);
    
    [_firstImage setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_secondImage setFrame:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_thirdImage setFrame:CGRectMake(_scrollView.frame.size.width * 2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_imageContainerView addSubview:_firstImage];
    [_imageContainerView addSubview:_secondImage];
    [_imageContainerView addSubview:_thirdImage];
}

@end
