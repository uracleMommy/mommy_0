//
//  MoreMyPageSubImageController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageSubImageController.h"

@interface MoreMyPageSubImageController ()

@end

@implementation MoreMyPageSubImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage *originalImage = [UIImage imageNamed:@"home_img_01"];
//    UIImage *bluredImage = [originalImage blurredImageWithRadius:30 iterations:30 tintColor:nil];
    
    _mommyImageButton.layer.cornerRadius = 50;//half of the width
    _mommyImageButton.layer.masksToBounds = YES;
    _defaultImage = [UIImage imageNamed:@"join_profile_photo.png"];
    [_mommyImageButton setImage:_defaultImage forState:UIControlStateNormal];
    
//    _backgroundImage.image = bluredImage;
    
//    home_img_01
//    
//    UIImage *blur;
//    if (self.blurred) {
//        blur = [image blurredImageWithRadius:30 iterations:1 tintColor:[UIColor blackColor]];
//    } else {
//        blur = [image blurredImageWithRadius:0 iterations:1 tintColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - picturebutton action
- (IBAction)mommyPictureButtonAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"사진"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    
    UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"사진보기"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             [self showImageView:sender];
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
    
    if(![[_mommyImageButton currentImage] isEqual:_defaultImage]){
        [alert addAction:showAction];
    }
    [alert addAction:takeAction]; // 4
    [alert addAction:selectAction]; // 5
    [alert addAction:cancelAction];
    
    
    [self presentViewController:alert animated:YES completion:nil]; // 6
}

-(void)showImageView:(id)sender {
    MoreMyPageMasterViewController *parentController = (MoreMyPageMasterViewController *)self.parentViewController;
    [parentController callImageView:[(UIButton*)sender currentImage]];
}

-(void)setMommyImage:(UIImage *)croppedImage{
    [_mommyImageButton setImage:croppedImage forState:UIControlStateNormal];
    [_mommyImageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    UIImage *blurImage = [croppedImage blurredImageWithRadius:50 iterations:5.0 tintColor:[UIColor blackColor]];;
    [_backgroundImage setImage:blurImage];
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
        [self libraryAuthorized];
    }
}

- (void)libraryAuthorized{
    MoreMyPageMasterViewController *parentController = (MoreMyPageMasterViewController *)self.parentViewController;
    [parentController callLibraryView];
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
        [self cameraAuthorized];
    }
}

- (void)cameraAuthorized{
    MoreMyPageMasterViewController *parentController = (MoreMyPageMasterViewController *)self.parentViewController;
    [parentController callCameraView];
}

- (void)cameraDenied{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"카메라를 이용하려면 카메라 접근이 필요합니다.\n\n단말기의 [설정>개인정보보호>카메라]에서 Mommy의 설정상태를 확인해주세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
    [alert show];
}

@end
