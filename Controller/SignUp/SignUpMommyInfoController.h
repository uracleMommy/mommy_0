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
#import "SignUpFetusInfoController.h"
#import "CommonViewController.h"
#import "ImageCropView.h"

@interface SignUpMommyInfoController : CommonViewController <SignUpMommyInfoScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate>{
    
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (strong, nonatomic) SingleImageViewController *singleImageView;
@property (strong, nonatomic) SignUpMommyInfoScrollViewController *scrollViewContoller;
@property (strong, nonatomic) ImageCropViewController *controller;
@property (strong, nonatomic) UIImagePickerController *cameraView;
@property (strong, nonatomic) UIImagePickerController *libraryView;
@property (strong, nonatomic) NSString *fileName;

- (IBAction)confirmButtonAction:(id)sender;

@end
