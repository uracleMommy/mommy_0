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
#import <CoreLocation/CoreLocation.h>
#import "IQDropDownTextField.h"
#import "AppDelegate.h"
#import "emoticonPopupViewController.h"
#import "ImageCropView.h"
#import "MultiImageViewController.h"
#import "CommonViewController.h"


@interface DiaryWriteBasicController : CommonViewController <UITextViewDelegate, IQDropDownTextFieldDelegate, ImageCropViewControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, emoticonPopupViewDelegate, CLLocationManagerDelegate> {
    UIButton *selectedImageButton;
    UIImage *defaultImage;
    ImageCropViewController *controller;
    UIImagePickerController *imagePickerController;
    UIImagePickerController *imagePicker;
}


@property (strong, nonatomic) MultiImageViewController *imageViewer;
@property (strong, nonatomic) NSMutableArray *files;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSMutableArray *pickerData_0; //거주지 시
@property (strong, nonatomic) NSMutableArray *pickerData_1; //거주지 구
@property (strong, nonatomic) NSMutableArray *pickerData_2; //거주지 동
@property (strong, nonatomic) UIPickerView *addressPicker;
@property (weak, nonatomic) IBOutlet UILabel *addressTextField;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (strong, nonatomic) UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *timeButton;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton;

@property (weak, nonatomic) IBOutlet UIButton *emoticonButton;
@property (weak, nonatomic) IBOutlet UIButton *imageButton01;
@property (weak, nonatomic) IBOutlet UIButton *imageButton02;
@property (weak, nonatomic) IBOutlet UIButton *imageButton03;
@property (weak, nonatomic) IBOutlet UIButton *imageButton04;

@property (assign, nonatomic) NSString *latitude;
@property (assign, nonatomic) NSString *longitude;

#pragma mark 이모티콘 팝업 관련
@property (strong, nonatomic) emoticonPopupViewController *emoticonPopupView;
- (IBAction)showEmoticonPopup:(id)sender;
- (IBAction)mommyPictureButtonAction:(id)sender;
- (void)clickButton:(int)tag;

- (IBAction)getGPSAction:(id)sender;

@end
