//
//  DiaryWriteBasicController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 17..
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

@interface DiaryWriteBasicController : UIViewController <UITextViewDelegate, IQDropDownTextFieldDelegate, ImageCropViewControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, emoticonPopupViewDelegate> {
    UIButton *selectedImageButton;
    UIImage *image;
    UIImage *defaultImage;
    ImageCropViewController *controller;
    UIImagePickerController *imagePickerController;
    UIImagePickerController *imagePicker;
}

@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton01;
@property (weak, nonatomic) IBOutlet UIButton *imageButton02;
@property (weak, nonatomic) IBOutlet UIButton *imageButton03;
@property (weak, nonatomic) IBOutlet UIButton *imageButton04;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *emoticonButton;
@property (strong, nonatomic) MultiImageViewController *imageViewer;

#pragma mark 이모티콘 팝업 관련
@property (strong, nonatomic) emoticonPopupViewController *emoticonPopupView;
- (IBAction)showEmoticonPopup:(id)sender;
- (IBAction)mommyPictureButtonAction:(id)sender;
- (void)clickButton:(int)tag;

@end