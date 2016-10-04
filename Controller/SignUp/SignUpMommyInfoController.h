//
//  SignUpMommyInfoController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "IQKeyboardManager.h"
#import "SignUpMommyInfoScrollViewController.h"
#import "ImageCropView.h"
#import "CommonViewController.h"

@interface SignUpMommyInfoController : CommonViewController <SignUpMommyInfoScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate>{
    SignUpMommyInfoScrollViewController *scrollViewContoller;
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (strong, nonatomic) SingleImageViewController *singleImageView;
@property (strong, nonatomic) ImageCropViewController *controller;
@property (strong, nonatomic) UIImagePickerController *cameraView;
@property (strong, nonatomic) UIImagePickerController *libraryView;

@end
