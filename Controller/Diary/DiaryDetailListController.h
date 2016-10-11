//
//  DiaryDetailListController.h
//  co.medisolution
//
//  Created by uracle on 2016. 10. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ViewController.h"
#import "CommonViewController.h"
#import "MultiImageViewController.h"
#import "emoticonPopupViewController.h"
#import "IQDropDownTextField.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "notPasteField.h"
#import "ImageCropView.h"

@interface DiaryDetailListController : CommonViewController <UITextViewDelegate, IQDropDownTextFieldDelegate, ImageCropViewControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, emoticonPopupViewDelegate>

@property (strong, nonatomic) MultiImageViewController *imageViewer;
@property (strong, nonatomic) NSMutableArray *files;
@property (assign, nonatomic) Boolean editFlag;

@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet notPasteField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *emoticonButton;
@property (weak, nonatomic) IBOutlet UIButton *imageButton01;
@property (weak, nonatomic) IBOutlet UIButton *imageButton02;
@property (weak, nonatomic) IBOutlet UIButton *imageButton03;
@property (weak, nonatomic) IBOutlet UIButton *imageButton04;
@property (strong, nonatomic) UIImage *defaultImage;
@property (strong, nonatomic) NSString *diaryKey;
@property (weak, nonatomic) IBOutlet UIView *imageButtonMomView;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;
//@property (strong, nonatomic) NSDictionary *result;


@property (strong, nonatomic) ImageCropViewController *controller;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIButton *selectedImageButton;
@property (weak, nonatomic) IBOutlet UITextField *addressButton;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *timeButton;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton;

#pragma mark 이모티콘 팝업 관련
@property (strong, nonatomic) emoticonPopupViewController *emoticonPopupView;
- (IBAction)showEmoticonPopup:(id)sender;
- (IBAction)mommyPictureButtonAction:(id)sender;
- (void)clickButton:(int)tag;

@end
