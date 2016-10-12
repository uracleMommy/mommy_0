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
#import "MoreProfessionalAdviceContentsViewController.h"
#import "MoreProfessionalAdviceReplyViewController.h"
#import "MoreProfessionalWriteAdviceController.h"

@interface MoreProfessionalDetailViewController : CommonViewController<MoreProfessionalAdviceContentsViewControllerDelegate>

@property (strong, nonatomic) NSString *replyYN;

@property (strong, nonatomic) NSDictionary *adviceInfo;

@property (strong, nonatomic) NSDictionary *fileInfo;

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segmentView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) NSArray *imageList; // 이미지 리스트

@property (strong, nonatomic) MultiImageViewController *multiImageViewController;

@property (strong, nonatomic) MoreProfessionalAdviceContentsViewController *detailContentViewController;

@property (strong, nonatomic) MoreProfessionalAdviceReplyViewController *moreProfessionalAdviceReplyViewController;

@property (strong, nonatomic) NSString *qnaKey;

@property (assign, readwrite) ProfessionalButtonKind professionalButtonKind;

@property (strong, nonatomic) UIButton *btnQuestionUpdate;

@property (strong, nonatomic) UIButton *btnQuestionDelete;

@property (strong, nonatomic) NSString *afterCUDYN;

@end
