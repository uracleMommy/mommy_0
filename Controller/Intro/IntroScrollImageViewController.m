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
    _scrollView.delegate = self;
    // 132 68 240
    _firstImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entry_img_01"]];
    _firstImage.backgroundColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _secondImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entry_img_02"]];
    _secondImage.backgroundColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _thirdImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"entry_img_03"]];
    _thirdImage.backgroundColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    
    _currentPageIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height)];
    [_imageContainerView setFrame:CGRectMake(0, 0, _scrollView.frame.size.width * 3, _scrollView.frame.size.height)];
    
    NSLog(@"스크롤뷰 사이즈 : %f %f", _scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollViewSize = _scrollView.frame.size.width;
    [_firstImage setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_secondImage setFrame:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_thirdImage setFrame:CGRectMake(_scrollView.frame.size.width * 2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_imageContainerView addSubview:_firstImage];
    [_imageContainerView addSubview:_secondImage];
    [_imageContainerView addSubview:_thirdImage];
}

- (void) moveScrollView : (UIScrollView *) scrollView {
    

    float ratioSizeX = 184.0f / 375.0f;
    
    float moveCompltedOffsetX = scrollView.contentOffset.x - 375.0f;
    
    float offsetX = (scrollView.contentOffset.x - 375.0f)  * ratioSizeX + 184.0f * _currentPageIndex ;
    
    if (moveCompltedOffsetX == 0) {
        
        return;
    }
    
    [_scrollView setContentOffset:CGPointMake(offsetX, 0)];
}

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex {
    
    if (pageIndex == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
    else if (pageIndex == 1) {
        [_scrollView setContentOffset:CGPointMake(184, 0)];
    }
    else if (pageIndex == 2) {
        [_scrollView setContentOffset:CGPointMake(368, 0)];
    }
    
    _currentPageIndex = pageIndex;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"하위 오프셋 : %f", scrollView.contentOffset.x);
    NSLog(@"하위 오프셋 : %f", scrollView.contentOffset.y);
    NSLog(@"컨텐츠 하위 사이즈 : %f", scrollView.contentSize.width);
    NSLog(@"컨텐츠 하위 사이즈 : %f", scrollView.contentSize.height);
}

@end
