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
    
    if (_adviceInfo[@"detail"][@"content"] == nil) {
        _txtContent.text = @"";
    }
    else {
        _txtContent.text = _adviceInfo[@"detail"][@"content"] ;
    }
    
    if (_adviceInfo[@"files"] != nil) {
        
        if ([_adviceInfo[@"files"] isKindOfClass:[NSArray class]]) {
            
            _imageList = [NSArray arrayWithArray:_adviceInfo[@"files"]];
        }
    }
    
    // 탭 제스쳐 추가하기
    for (int i = 0; i < _imageList.count; i++) {
        
        NSDictionary *dic = _imageList[i];
        NSString *imageUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], dic[@"atch_file_key"]];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        if (i == 0) {
            
            _firstTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _firstImgView.tag = i;
            [_firstImgView addGestureRecognizer:_firstTapGestureRecognizer];
            [_firstImgView setImage:[UIImage imageWithData:imageData]];
        }
        else if (i == 1) {
            
            _secondTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _secondImageView.tag = i;
            [_secondImageView addGestureRecognizer:_secondTapGestureRecognizer];
            [_secondImageView setImage:[UIImage imageWithData:imageData]];
        }
        else if (i == 2) {
            _thirdTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _thirdImageView.tag = i;
            [_thirdImageView addGestureRecognizer:_thirdTapGestureRecognizer];
            [_thirdImageView setImage:[UIImage imageWithData:imageData]];
        }
        else {
            _fourthTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            _fourthImageView.tag = i;
            [_fourthImageView addGestureRecognizer:_fourthTapGestureRecognizer];
            [_fourthImageView setImage:[UIImage imageWithData:imageData]];
        }
    }
}

- (void) viewDidLayoutSubviews {
    
    if (_imageList == nil) {
        
        [_txtContent setFrame:CGRectMake(0, 0, _txtContent.frame.size.width, self.view.frame.size.height)];
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
