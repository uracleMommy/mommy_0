//
//  SingleImageViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SingleImageViewController.h"
#import "AppDelegate.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

@interface SingleImageViewController ()

@end

@implementation SingleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 코드 오토 레이아웃 처리
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self.view addGestureRecognizer:tap];
}

- (void) closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.view removeFromSuperview];
}

- (void) viewDidLayoutSubviews {
    
//    _originalImage = [UIImage imageNamed:@"screen1"];
    float oldImageWidth = _originalImage.size.width;
    float oldImageHeight = _originalImage.size.height;
    
    NSLog(@"%f", self.view.frame.size.width);
    
    float scaleFactor = self.view.frame.size.width / oldImageWidth;
    float newHeight = oldImageHeight * scaleFactor;
    
    [_imageView setImage:_originalImage];
    
    _imageWidthConstraint.constant = self.view.frame.size.width;
    _imageHeightConstraint.constant = newHeight;
}

#pragma 비율유지하면서 이미지 사이즈 조절
- (UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void) imageTap {
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = _originalImage;
    
    imageInfo.referenceRect = _imageView.frame;
    //imageInfo.referenceView = _imageView.superview;
    imageInfo.referenceContentMode = _imageView.contentMode;
    imageInfo.referenceCornerRadius = _imageView.layer.cornerRadius;
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)btnCloseAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end