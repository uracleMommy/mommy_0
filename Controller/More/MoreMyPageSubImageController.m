//
//  MoreMyPageSubImageController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageSubImageController.h"
#import "FXBlurView.h"

@interface MoreMyPageSubImageController ()

@end

@implementation MoreMyPageSubImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *originalImage = [UIImage imageNamed:@"home_img_01"];
    UIImage *bluredImage = [originalImage blurredImageWithRadius:30 iterations:30 tintColor:nil];
    
    _backgroundImage.image = bluredImage;
    
//    home_img_01
//    
//    UIImage *blur;
//    if (self.blurred) {
//        blur = [image blurredImageWithRadius:30 iterations:1 tintColor:[UIColor blackColor]];
//    } else {
//        blur = [image blurredImageWithRadius:0 iterations:1 tintColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
