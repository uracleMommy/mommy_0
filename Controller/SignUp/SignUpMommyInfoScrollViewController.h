//
//  SignUpMommyInfoScrollViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropView.h"
#import "IQDropDownTextField.h"

@interface SignUpMommyInfoScrollViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate>{
    UIImagePickerController *imagePicker;
    UIImagePickerController *imagePickerController;
    ImageCropViewController *controller;
}

- (IBAction)mommyPictureButtonAction:(id)sender;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;


@property (weak, nonatomic) IBOutlet IQDropDownTextField *fetusCountTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *beforeWeightTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dueDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *mommyNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *mommyNameValidationLabel;
@property (weak, nonatomic) IBOutlet UIButton *mommyImageButton;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *defaultImage;



@end
