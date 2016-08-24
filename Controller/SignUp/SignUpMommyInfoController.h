//
//  SignUpMommyInfoController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropView.h"

@interface SignUpMommyInfoController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate>

- (IBAction)mommyPictureButtonAction:(id)sender;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

@property (weak, nonatomic) IBOutlet UITextField *mommyNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *mommyNameValidationLabel;
@property (weak, nonatomic) IBOutlet UIButton *mommyImageButton;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *defaultImage;


@end
