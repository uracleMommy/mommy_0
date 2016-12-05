//
//  SignUpMommyInfoScrollViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "SingleImageViewController.h"
#import "IQKeyboardManager.h"
#import "IQDropDownTextField.h"
#import "FXBlurView.h"
#import "CommonViewController.h"

@protocol SignUpMommyInfoScrollViewDelegate <NSObject>

-(void)callCameraView;
-(void)callLibraryView;
-(void)callImageView:(UIImage*)image;

@end

@interface SignUpMommyInfoScrollViewController : CommonViewController <UINavigationControllerDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
//    NSMutableArray *pickerData_0; //거주지 시
//    NSMutableArray *pickerData_1; //거주지 구
//    NSMutableArray *pickerData_2; //거주지 동
    NSMutableArray *pickerData_address; //거주지
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
- (void)setMommyImage:(UIImage *)croppedImage;

@property (strong, nonatomic) NSMutableDictionary *addressCodeDic;
@property (weak, nonatomic)id<SignUpMommyInfoScrollViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *mommyBackImageView;
@property (weak, nonatomic) IBOutlet UITextField *mommyNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *mommyNameValidationLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *addressTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dueDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *beforeWeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *nowWeightTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *heightTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *fetusCountTextField;
@property (weak, nonatomic) IBOutlet UIButton *mommyImageButton;
@property (strong, nonatomic) UIImage *defaultImage;
@property (strong, nonatomic) NSMutableArray *nicknameValidationArr;



@end
