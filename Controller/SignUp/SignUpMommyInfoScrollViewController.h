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

@interface SignUpMommyInfoScrollViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIImagePickerControllerDelegate, ImageCropViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    UIImagePickerController *imagePicker;
    UIImagePickerController *imagePickerController;
    ImageCropViewController *controller;
    NSMutableArray *pickerData_0; //거주지 시
    NSMutableArray *pickerData_1; //거주지 구
    NSMutableArray *pickerData_2; //거주지 동
    NSMutableArray *pickerData_number_point; //소수점 1자리
    NSMutableArray *pickerData_number_fetus; //태아 정보
    NSMutableArray *pickerData_number_weight; //체중
    NSMutableArray *pickerData_number_height; //키
    UIPickerView *beforeWeightPicker;
    UIPickerView *nowWeightPicker;
    UIPickerView *heightPicker;
    UIPickerView *addressPicker;
}

- (IBAction)mommyPictureButtonAction:(id)sender;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;


@property (weak, nonatomic) IBOutlet IQDropDownTextField *fetusCountTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dueDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *nowWeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *beforeWeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *mommyNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *mommyNameValidationLabel;
@property (weak, nonatomic) IBOutlet UIButton *mommyImageButton;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *defaultImage;



@end
