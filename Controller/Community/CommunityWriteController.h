//
//  CommunityWriteController.h
//  co.medisolution
//
//  Created by uracle on 2016. 10. 11..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import "MultiImageViewController.h"
#import "CommonViewController.h"
#import "ImageCropView.h"
#import "AppDelegate.h"

@interface CommunityWriteController : CommonViewController <UITextViewDelegate, ImageCropViewControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate> {
    UIButton *selectedImageButton;
    UIImage *defaultImage;
    ImageCropViewController *controller;
    UIImagePickerController *imagePickerController;
    UIImagePickerController *imagePicker;
}

@property (strong, nonatomic) MultiImageViewController *imageViewer;
@property (strong, nonatomic) NSMutableArray *files;

@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (strong, nonatomic) UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UIButton *imageButton01;
@property (weak, nonatomic) IBOutlet UIButton *imageButton02;
@property (weak, nonatomic) IBOutlet UIButton *imageButton03;
@property (weak, nonatomic) IBOutlet UIButton *imageButton04;

- (IBAction)mommyPictureButtonAction:(id)sender;
@end
