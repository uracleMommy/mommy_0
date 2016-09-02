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
    
    
    [_dueDateTextField setDropDownMode : IQDropDownModeDatePicker];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    [_dueDateTextField setDateFormatter:formatter];
    
    [_fetusCountTextField setDropDownMode : IQDropDownModeTextPicker];
    [_fetusCountTextField setItemList:@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]];
   
//    [_dueDateTextField setDropDownMode : IQDropDownModeTextPicker];
//    [_dueDateTextField setItemList:@[@"Zero Line Of Code",
//                                     @"No More UIScrollView",
//                                     @"No More Subclasses",
//                                     @"No More Manual Work",
//                                     @"No More #imports",
//                                     @"Device Orientation support",
//                                     @"UITextField Category for Keyboard",
//                                     @"Enable/Desable Keyboard Manager",
//                                     @"Customize InputView support",
//                                     @"IQTextView for placeholder support",
//                                     @"Automanage keyboard toolbar",
//                                     @"Can set keyboard and textFiled distance",
//                                     @"Can resign on touching outside",
//                                     @"Auto adjust textView's height ",
//                                     @"Adopt tintColor from textField",
//                                     @"Customize keyboardAppearance",
//                                     @"play sound on next/prev/done"]];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
