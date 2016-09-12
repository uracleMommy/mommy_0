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

@interface SignUpMommyInfoController : UIViewController<SignUpMommyInfoScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate>{
    SignUpMommyInfoScrollViewController *scrollViewContoller;
    ImageCropViewController *controller;
    UIImagePickerController *cameraView;
    UIImagePickerController *libraryView;
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@end
