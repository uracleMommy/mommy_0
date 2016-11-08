//
//  MoreMyPageMasterViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreMyPageSubImageController.h"
#import "MoreMyPageSubInfoPanelController.h"
#import "MoreMyPageFetusInfoChangeViewController.h"
#import "MoreMyPageNickNameChangeViewController.h"
#import "SingleImageViewController.h"
#import "ImageCropView.h"

@class MoreMyPageSubImageController;
@class MoreMyPageSubInfoPanelController;

@interface MoreMyPageMasterViewController : CommonViewController <ImageCropViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewBottomConstraint;

@property (strong, nonatomic) MoreMyPageSubInfoPanelController *moreMyPageSubInfoPanelController;
@property (strong, nonatomic) MoreMyPageSubImageController *moreMyPageSubImageController;

@property (strong, nonatomic) SingleImageViewController *singleImageView;
@property (strong, nonatomic) ImageCropViewController *controller;
@property (strong, nonatomic) UIImagePickerController *cameraView;
@property (strong, nonatomic) UIImagePickerController *libraryView;
@property (strong, nonatomic) NSArray *babyNickNames;
@property (strong, nonatomic) id selectedItem;
@property (strong, nonatomic) NSDictionary *result;

#pragma mark 모달 창 관련
- (IBAction)closeModal:(id)sender;
- (IBAction)deleteUserAction:(id)sender;
- (void) modalChangeInfo:(id)sender;
- (void) modalFetusChange;


-(void)callCameraView;
-(void)callLibraryView;
-(void)callImageView:(UIImage*)image;

@end
