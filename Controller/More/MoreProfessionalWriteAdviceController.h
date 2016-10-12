//
//  MoreProfessionalWriteAdviceController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "IQDropDownTextField.h"
#import "AppDelegate.h"
#import "emoticonPopupViewController.h"
#import "MultiImageViewController.h"
#import "ImageCropView.h"
#import "CommonViewController.h"

@interface MoreProfessionalWriteAdviceController : CommonViewController<UITextViewDelegate, IQDropDownTextFieldDelegate, ImageCropViewControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIPickerViewDelegate> {
    UIButton *selectedImageButton;
    UIImage *defaultImage;
    ImageCropViewController *controller;
    UIImagePickerController *imagePickerController;
    UIImagePickerController *imagePicker;
}

@property (strong, nonatomic) MultiImageViewController *imageViewer;

@property (strong, nonatomic) NSMutableArray *files;

@property (strong, nonatomic) NSMutableArray *imageFiles;

@property (weak, nonatomic) IBOutlet UITextView *txtContent;

@property (weak, nonatomic) IBOutlet UIButton *imageButton01;

@property (weak, nonatomic) IBOutlet UIButton *imageButton02;

@property (weak, nonatomic) IBOutlet UIButton *imageButton03;

@property (weak, nonatomic) IBOutlet UIButton *imageButton04;

@property (assign) ProfessionalButtonKind professionalButtonKind;

- (IBAction)mommyPictureButtonAction:(id)sender;

@property (strong, nonatomic) NSString *qnaKey; // 게시글 키

@property (assign, readwrite) ProfessionalQuestionWriteUpdateMode professionalQuestionWriteUpdateMode; // 글쓰기/업데이트 모드


@end
