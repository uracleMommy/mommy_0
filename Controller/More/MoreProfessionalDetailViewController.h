//
//  MoreProfessionalDetailViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"
#import "MultiImageViewController.h"

@interface MoreProfessionalDetailViewController : CommonViewController

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segmentView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (weak, nonatomic) IBOutlet UIImageView *fourthImageView;

@property (strong, nonatomic) NSArray *imageList; // 이미지 리스트

@property (strong, nonatomic) MultiImageViewController *multiImageViewController;

@end
