//
//  SignUpMommyInfoScrollViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMommyInfoScrollViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface SignUpMommyInfoScrollViewController ()

@end

@implementation SignUpMommyInfoScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mommyImageButton.layer.cornerRadius = 50;//half of the width
    _mommyImageButton.layer.masksToBounds = YES;
    _defaultImage = [UIImage imageNamed:@"join_profile_photo.png"];
    [_mommyImageButton setImage:_defaultImage forState:UIControlStateNormal];
    
    
    pickerData_0 = [[NSMutableArray alloc]initWithArray:@[@"Select", @"서울시", @"경기도"]];
    pickerData_1 = [[NSMutableArray alloc]initWithArray:@[@"Select"]];
    pickerData_2 = [[NSMutableArray alloc]initWithArray:@[@"Select"]];
    
    pickerData_number_point = [[NSMutableArray alloc]init]; //소수점 1자리
    pickerData_number_weight = [[NSMutableArray alloc]initWithArray:@[@"Select"]]; //체중
    pickerData_number_height = [[NSMutableArray alloc]initWithArray:@[@"Select"]]; //키
    pickerData_number_fetus = [[NSMutableArray alloc]init]; //태아 정보
    
    for(int i = 0 ; i < 1000 ; i++){
        if(i < 10){
            [pickerData_number_point addObject: [NSString stringWithFormat:@".%d", i]];
            [pickerData_number_fetus addObject: [NSString stringWithFormat:@"%d", i]];
        }else if( i > 10 && i < 100){
            [pickerData_number_weight addObject: [NSString stringWithFormat:@"%d", i]];
        }else if( i > 100 && i < 500){
            [pickerData_number_height addObject: [NSString stringWithFormat:@"%d", i]];
        }
    }
    
    
    beforeWeightPicker = [[UIPickerView alloc] init];
    beforeWeightPicker.dataSource = self;
    beforeWeightPicker.delegate = self;
    [_beforeWeightTextField setInputView:beforeWeightPicker];
    
    nowWeightPicker = [[UIPickerView alloc] init];
    nowWeightPicker.dataSource = self;
    nowWeightPicker.delegate = self;
    [_nowWeightTextField setInputView:nowWeightPicker];
    
    heightPicker = [[UIPickerView alloc] init];
    heightPicker.dataSource = self;
    heightPicker.delegate = self;
    [_heightTextField setInputView:heightPicker];
    
    addressPicker = [[UIPickerView alloc] init];
    addressPicker.dataSource = self;
    addressPicker.delegate = self;
    [_addressTextField setInputView:addressPicker];
    
    
    [_dueDateTextField setDropDownMode : IQDropDownModeDatePicker];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    [_dueDateTextField setDateFormatter:formatter];
    [_dueDateTextField setMinimumDate:[NSDate date]];
    
    [_fetusCountTextField setDropDownMode : IQDropDownModeTextPicker];
    [_fetusCountTextField setItemList:pickerData_number_fetus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark pikerView

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labelText = [[UILabel alloc] init];
    [labelText setTextAlignment:NSTextAlignmentCenter];
    [labelText setAdjustsFontSizeToFitWidth:YES];
    labelText.backgroundColor = [UIColor clearColor];
    
    if([pickerView isEqual:addressPicker]){
        if(component == 0){
            [labelText setText:pickerData_0[row]];
        }else if(component == 1){
            [labelText setText:pickerData_1[row]];
        }else{
            [labelText setText:pickerData_2[row]];
        }
        
        if (row == 0)
        {
            labelText.font = [UIFont boldSystemFontOfSize:30.0];
            labelText.textColor = [UIColor lightGrayColor];
        }
        else
        {
            labelText.font = [UIFont boldSystemFontOfSize:18.0];
            labelText.textColor = [UIColor blackColor];
        }
    }else{
        if(component == 0){
            if([pickerView isEqual:beforeWeightPicker] || [pickerView isEqual:nowWeightPicker]){
                [labelText setText:pickerData_number_weight[row]];
            }else{
                [labelText setText:pickerData_number_height[row]];
            }
            
            if (row == 0)
            {
                labelText.font = [UIFont boldSystemFontOfSize:30.0];
                labelText.textColor = [UIColor lightGrayColor];
            }
            else
            {
                labelText.font = [UIFont boldSystemFontOfSize:18.0];
                labelText.textColor = [UIColor blackColor];
            }
            
        }else{
            [labelText setText:pickerData_number_point[row]];
            
            labelText.font = [UIFont boldSystemFontOfSize:18.0];
            labelText.textColor = [UIColor blackColor];
        }

    }
    
    return labelText;
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if([pickerView isEqual:addressPicker]){
        return 3;
    }else{
        return 2;
    }
    
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 0;
    
    if([pickerView isEqual:addressPicker]){
        if(component == 0){
            count = [pickerData_0 count];
        }else if(component == 1){
            count = [pickerData_1 count];
        }else{
            count = [pickerData_2 count];
        }
    }else{
        if(component == 0){
            if([pickerView isEqual:beforeWeightPicker] || [pickerView isEqual:nowWeightPicker]){
                count = [pickerData_number_weight count];
            }else{
                count = [pickerData_number_height count];
            }
        }else{
            count = [pickerData_number_point count];
        }
    }
    

    return count;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    NSMutableString *value = [[NSMutableString alloc]init];
    
    if([pickerView isEqual:addressPicker]){
        if(component == 0){
            if(row == 0){
                [pickerData_1 setArray:@[@"Select"]];
            }else{
                [pickerData_1 setArray:@[@"Select", @"노원구", @"도봉구", @"성북구", @"송파구", @"강북구"]];
            }
            [pickerData_2 setArray:@[@"Select"]];
            
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
        }else if(component == 1){
            if(row == 0){
                [pickerData_2 setArray:@[@"Select"]];
            }else{
                [pickerData_2 setArray:@[@"Select", @"쌍문 1동", @"쌍문 2동", @"쌍문 3동", @"쌍문 4동", @"쌍문 5동"]];
            }
            [pickerView reloadComponent:2];
        }
        
        if([pickerView selectedRowInComponent:0] != 0 && [pickerView selectedRowInComponent:1] != 0 && [pickerView selectedRowInComponent:2] != 0){
            [value appendString:[NSString stringWithFormat:@"%@ %@ %@", pickerData_0[[pickerView selectedRowInComponent:0]], pickerData_1[[pickerView selectedRowInComponent:1]], pickerData_2[[pickerView selectedRowInComponent:2]]]];
        }
        
        _addressTextField.text = value;
    }else if([pickerView selectedRowInComponent:0] != 0){
        if([pickerView isEqual:beforeWeightPicker] || [pickerView isEqual:nowWeightPicker]){
            [value appendString:[NSString stringWithFormat:@"%@", pickerData_number_weight[[pickerView selectedRowInComponent:0]]]];
        }else{
            [value appendString:pickerData_number_height[[pickerView selectedRowInComponent:0]]];
        }
        
        [value appendString:pickerData_number_point[[pickerView selectedRowInComponent:1]]];
        
        if([pickerView isEqual:beforeWeightPicker]){
            _beforeWeightTextField.text = value;
        }else if([pickerView isEqual:nowWeightPicker]){
            _nowWeightTextField.text = value;
        }else{
            _heightTextField.text = value;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - picturebutton action
- (IBAction)mommyPictureButtonAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"사진"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    //    UIAlertControllerStyleActionSheet
    
    UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"사진보기"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             NSLog(@"You pressed button one");
                                                         }]; // 2
    
    UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"카메라로 사진찍기"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                             {
                                                                 [self checkCameraAuthorization];
                                                             }
                                                             else
                                                             {
                                                                 [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your device doesn't have a camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                                             }
                                                             NSLog(@"You pressed button two");
                                                         }]; // 3
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"사진앨범에서 선택하기"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               NSLog(@"You pressed button three");
                                                               
                                                               [self checkLibraryAuthorization];
                                                           }]; // 3
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                           }]; // 3
    
    if([_mommyImageButton currentImage] != _defaultImage){
        [alert addAction:showAction];
    }
    [alert addAction:takeAction]; // 4
    [alert addAction:selectAction]; // 5
    [alert addAction:cancelAction];
    
    
    [self presentViewController:alert animated:YES completion:nil]; // 6
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"PSH picker!!");
    _image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //    imageView.image = image;
    
    if(controller == nil){
        controller = [[ImageCropViewController alloc] initWithImage:_image];
        controller.delegate = self;
        controller.blurredBackground = YES;
    }else{
        [controller setImage:_image];
    }
    // set the cropped area
    // controller.cropArea = CGRectMake(0, 0, 100, 200);
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    //TEMP pickerview navigation 처리 전 주석
//    [self presentViewController:controller animated:YES completion:nil];
    
    [_mommyImageButton setImage:_image forState:UIControlStateNormal];
    [_mommyImageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];

    
}


#pragma mark cropView Delegate
//- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
//    [_mommyImageButton setImage:_image forState:UIControlStateNormal];
//    [[self navigationController] popViewControllerAnimated:YES];
//}

-(void)ImageCropViewControllerSuccess:(UIViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    _image = croppedImage;
    
    [_mommyImageButton setImage:[self imageByScalingProportionallyToSize:CGSizeMake( _mommyImageButton.frame.size.width, _mommyImageButton.frame.size.height) sourceImage:croppedImage] forState:UIControlStateNormal];
    //    CGRect cropArea = controller.cropArea;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize sourceImage:(UIImage*)sourceImage {
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}



#pragma mark Library Function

-(void) checkLibraryAuthorization {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if(status == PHAuthorizationStatusAuthorized) { // authorized
        NSLog(@"library authorized");
        
        [self libraryAuthorized];
    }
    else if(status == PHAuthorizationStatusDenied){ // denied
        [self libraryDenied];
    }
    else if(status == PHAuthorizationStatusRestricted){ // restricted
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your device doesn't have a library." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else if(status == PHAuthorizationStatusNotDetermined){ // not determined
        //        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //
        //            if (status == PHAuthorizationStatusAuthorized) {
        //                // Access has been granted.
        [self libraryAuthorized];
        //            }
        //
        //            else {
        //                // Access has been denied.
        //                [self libraryDenied];
        //            }
        //        }];
    }
}

- (void)libraryAuthorized{
    if(imagePickerController == nil){
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
    }
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)libraryDenied{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"사진을 이용하려면 사진 접근이 필요합니다.\n\n단말기의 [설정>개인정보보호>사진]에서 Mommy의 설정상태를 확인해주세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
    [alert show];
}


#pragma mark Camera Function

-(void) checkCameraAuthorization {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(status == AVAuthorizationStatusAuthorized) { // authorized
        NSLog(@"camera authorized");
        
        [self cameraAuthorized];
    }
    else if(status == AVAuthorizationStatusDenied){ // denied
        [self cameraDenied];
    }
    else if(status == AVAuthorizationStatusRestricted){ // restricted
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your device doesn't have a camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else if(status == AVAuthorizationStatusNotDetermined){ // not determined
        
        //        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        //            if(granted){ // Access has been granted ..do something
        //                NSLog(@"camera authorized");
        [self cameraAuthorized];
        //            } else { // Access denied ..do something
        //                [self cameraDenied];
        //            }
        //        }];
    }
}

- (void)cameraAuthorized{
    if(imagePicker == nil){
        imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setDelegate:self];
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)cameraDenied{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"카메라를 이용하려면 카메라 접근이 필요합니다.\n\n단말기의 [설정>개인정보보호>카메라]에서 Mommy의 설정상태를 확인해주세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
    [alert show];
}

#pragma mark UITextField Delegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField == _mommyNameTextField){
        NSString *mommyText = [[NSString alloc] initWithString:_mommyNameTextField.text];
        if([mommyText isEqualToString:@""]){
            _mommyNameValidationLabel.textColor = [UIColor lightGrayColor];
            return YES;
        }
        
        if([mommyText length] > 0 && [mommyText length] < 11){
            NSLog(@"1~10자 이내");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _mommyNameValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 5)];
            [_mommyNameValidationLabel setAttributedText: text];
        }else{
            NSLog(@"2번째 빨강");
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _mommyNameValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(0, 5)];
            [_mommyNameValidationLabel setAttributedText: text];
        }
        
        
        
        
        //영문, 숫자구성
        //5~12자 이내
        //중복되지않음
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

@end
