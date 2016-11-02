//
//  MoreProfessionalAdviceContentsViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiImageViewController.h"
#import "CommonViewController.h"

@protocol MoreProfessionalAdviceContentsViewControllerDelegate;

@interface MoreProfessionalAdviceContentsViewController : CommonViewController

@property (strong, nonatomic) NSDictionary *adviceInfo;

@property (weak, nonatomic) IBOutlet UIView *imageViewContainer;

@property (weak, nonatomic) IBOutlet UITextView *txtContent;

@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (weak, nonatomic) IBOutlet UIImageView *fourthImageView;

@property (strong, nonatomic) NSArray *imageList; // 이미지 리스트

@property (strong, nonatomic) NSMutableArray *uiImageList; // 이미지 리스트

@property (strong, nonatomic) MultiImageViewController *multiImageViewController;

@property (strong, nonatomic) id<MoreProfessionalAdviceContentsViewControllerDelegate> delegate;
#pragma mark 탭 제스쳐 관련

@property (strong, nonatomic) UITapGestureRecognizer *firstTapGestureRecognizer;

@property (strong, nonatomic) UITapGestureRecognizer *secondTapGestureRecognizer;

@property (strong, nonatomic) UITapGestureRecognizer *thirdTapGestureRecognizer;

@property (strong, nonatomic) UITapGestureRecognizer *fourthTapGestureRecognizer;

@end

@protocol MoreProfessionalAdviceContentsViewControllerDelegate <NSObject>

@required

- (void) imageArray : (NSArray *) imageArray startIndex : (NSInteger) startIndex;

@end
