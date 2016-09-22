//
//  MoreProfessionalAdviceContentsViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalAdviceContentsViewController.h"

@interface MoreProfessionalAdviceContentsViewController ()

@end

@implementation MoreProfessionalAdviceContentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageList = [NSArray arrayWithObjects:[UIImage imageNamed:@"home_img_01"], [UIImage imageNamed:@"home_img_02"], [UIImage imageNamed:@"home_img_03"], [UIImage imageNamed:@"home_img_04"],nil];
    
    // 탭 제스쳐 추가하기
    for (int i = 0; i < _imageList.count; i++) {
        
        if (i == 0) {
            _firstTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _firstImgView.tag = i;
            [_firstImgView addGestureRecognizer:_firstTapGestureRecognizer];
        }
        else if (i == 1) {
            _secondTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _secondImageView.tag = i;
            [_secondImageView addGestureRecognizer:_secondTapGestureRecognizer];
        }
        else if (i == 2) {
            _thirdTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _thirdImageView.tag = i;
            [_thirdImageView addGestureRecognizer:_thirdTapGestureRecognizer];
        }
        else {
            _fourthTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _fourthImageView.tag = i;
            [_fourthImageView addGestureRecognizer:_fourthTapGestureRecognizer];
        }
    }
}

#pragma 이미지 터치
- (void) imageTap : (id) sender {
    
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
    
//    _multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
//    _multiImageViewController.imgArray = [NSArray arrayWithArray:_imageList];
//    _multiImageViewController.index = (int)tapGesture.view.tag;    
    
    if ([self.delegate respondsToSelector:@selector(imageArray:startIndex:)]) {
        [self.delegate imageArray:_imageList startIndex:tapGesture.view.tag];
    }
    
    
//    [self presentViewController:_multiImageViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
