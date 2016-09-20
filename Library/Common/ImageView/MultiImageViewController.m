//
//  MultiImageViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MultiImageViewController.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

@interface MultiImageViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)closeView:(id)sender;

@end

@implementation MultiImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    _imgArray = [NSArray arrayWithObjects:@"0", @"1", @"2", nil];
    
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    
    float scrollViewWidth = _imgArray.count * windowSize.size.width;
    float scrollViewHeight = windowSize.size.height;
    
    _scrollView.contentSize = CGSizeMake(scrollViewWidth, scrollViewHeight);
    
    //NSLog(@"%f", windowSize.size.width);
    
    for (int i = 0; i < _imgArray.count; i++) {
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(i * windowSize.size.width, 0, windowSize.size.width, windowSize.size.height)];
        [containerView setBackgroundColor:[UIColor blackColor]];
        [_scrollView addSubview:containerView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * windowSize.size.width, windowSize.size.width, windowSize.size.height)];
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        imageTap.view.tag = i;
        [imageView addGestureRecognizer:imageTap];
        imageView.userInteractionEnabled = YES;
        [containerView addSubview:imageView];
        
        NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self.view addConstraint:xCenterConstraint];
        [self.view addConstraint:yCenterConstraint];
        
        UIImage *originalImage;
        
//        originalImage = [UIImage imageNamed:[NSString stringWithFormat:@"home_img_0%d", i+1]];
        originalImage = (UIImage *)[_imgArray objectAtIndex:i];
        float oldImageWidth = originalImage.size.width;
        float oldImageHeight = originalImage.size.height;
        
        float scaleFactor = windowSize.size.width / oldImageWidth;
        float newHeight = oldImageHeight * scaleFactor;
        
        float newPositionY = (windowSize.size.height - newHeight) / 2;
        
        [imageView setImage:originalImage];
        
        [imageView setFrame:CGRectMake(0, newPositionY, windowSize.size.width, newHeight)];
    }
    
    [_scrollView setContentOffset:CGPointMake(windowSize.size.width*_index, 0)];
    _pageControl.currentPage = _index;
    _pageControl.numberOfPages = _imgArray.count;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page =  floor((_scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

#pragma 이미지 탭
- (void) imageTap : (id) sender {
    
    UITapGestureRecognizer *gestureRecognizer = (UITapGestureRecognizer *)sender;
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = (UIImage *)_imgArray[gestureRecognizer.view.tag]; //[UIImage imageNamed:@"home_img_01"];
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
//    imageInfo.referenceRect = self.bigImageButton.frame;
//    imageInfo.referenceView = self.bigImageButton.superview;
//    imageInfo.referenceContentMode = self.bigImageButton.contentMode;
//    imageInfo.referenceCornerRadius = self.bigImageButton.layer.cornerRadius;
    
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
}

- (IBAction)closeView:(id)sender {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // [self.view removeFromSuperview];
}

@end
