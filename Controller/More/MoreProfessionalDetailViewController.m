//
//  MoreProfessionalDetailViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalDetailViewController.h"


@interface MoreProfessionalDetailViewController ()

@end

@implementation MoreProfessionalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageList = [NSArray arrayWithObjects:[UIImage imageNamed:@"home_img_01"], [UIImage imageNamed:@"home_img_02"], [UIImage imageNamed:@"home_img_03"], [UIImage imageNamed:@"home_img_04"],nil];
    
    // 탭 제스쳐 추가하기
    for (int i = 0; i < _imageList.count; i++) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        
        if (i == 0) {
            
            _firstImgView.tag = i;
            [_firstImgView addGestureRecognizer:tapGesture];
        }
        else if (i == 1) {
            
            _secondImageView.tag = i;
            [_secondImageView addGestureRecognizer:tapGesture];
        }
        else if (i == 2) {
            
            _thirdImageView.tag = i;
            [_thirdImageView addGestureRecognizer:tapGesture];
        }
        else {
            
            _fourthImageView.tag = i;
            [_fourthImageView addGestureRecognizer:tapGesture];
        }
    }
}

#pragma mark 이미지 터치 관련

#pragma 이미지 터치
- (void) imageTap : (id) sender {
    
    UITapGestureRecognizer *tapGesture = (UITapGestureRecognizer *)sender;
    
    _multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
    _multiImageViewController.imgArray = [NSArray arrayWithArray:_imageList];
    _multiImageViewController.index = (int)tapGesture.view.tag;
    
    [self presentViewController:_multiImageViewController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
