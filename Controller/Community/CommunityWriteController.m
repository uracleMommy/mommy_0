//
//  CommunityWriteController.m
//  co.medisolution
//
//  Created by uracle on 2016. 10. 11..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityWriteController.h"

@interface CommunityWriteController ()

@end

@implementation CommunityWriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** Navigation Setting **/
    //close Button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    //save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(insertCommunity) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    
    /** Placeholder Setting **/
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    [_placeholderLabel setFont:[UIFont fontWithName:@"NanumBarunGothic" size:15]];
    _contentsTextView.delegate = self;
    [_contentsTextView addSubview:_placeholderLabel];
    [_contentsTextView setTextContainerInset:UIEdgeInsetsMake(8, -5, 0, 0)];
    
    /** imageButton Radius, defaultImage Setting **/
    defaultImage = [UIImage imageNamed:@"contents_btn_photo_update.png"];
    
    _imageButton01.layer.cornerRadius = 20;//half of the width
    _imageButton01.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton01.layer.borderWidth = 2.0f;
    _imageButton01.layer.masksToBounds = YES;
    [_imageButton01 setImage:defaultImage forState:UIControlStateNormal];
    
    _imageButton02.layer.cornerRadius = 20;//half of the width
    _imageButton02.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton02.layer.borderWidth = 2.0f;
    _imageButton02.layer.masksToBounds = YES;
    [_imageButton02 setImage:defaultImage forState:UIControlStateNormal];
    
    _imageButton03.layer.cornerRadius = 20;//half of the width
    _imageButton03.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton03.layer.borderWidth = 2.0f;
    _imageButton03.layer.masksToBounds = YES;
    [_imageButton03 setImage:defaultImage forState:UIControlStateNormal];
    
    _imageButton04.layer.cornerRadius = 20;//half of the width
    _imageButton04.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton04.layer.borderWidth = 2.0f;
    _imageButton04.layer.masksToBounds = YES;
    [_imageButton04 setImage:defaultImage forState:UIControlStateNormal];
    
    _files = [[NSMutableArray alloc] init];
    
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

#pragma mark Navigation Button Action
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCommunity{
    if([_contentsTextView.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"입력하신 내용을 다시 확인해주세요."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self showIndicator];
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        
        for(int i = 0 ; i<_files.count ; i++){
            NSMutableDictionary *imageObj = [[NSMutableDictionary alloc] init];
            [imageObj setValue:[_files objectAtIndex:i] forKey:@"file_name"];
            [images addObject:imageObj];
        }
        
        
        [param setValue:_contentsTextView.text forKey:@"content"];
        [param setValue:images forKey:@"images"];
        
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            NSLog(@"data : %@", data);
            if([code isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self goBack];
                });
            }else{
                NSLog(@"Fail");
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self hideIndicator];
            });
        } error:^(NSError *error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self hideIndicator];
            });
        }];
    }
}


#pragma mark UITextView Delegate (placeholder)
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(![textView hasText]) {
        _placeholderLabel.hidden = NO;
    }
    else{
        _placeholderLabel.hidden = YES;
    }
}

#pragma mark - ImageClick Action
- (IBAction)mommyPictureButtonAction:(id)sender {
    selectedImageButton = sender;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"사진"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"사진보기"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                             [self showImageViewer:sender];
                                                             NSLog(@"You pressed button one");
                                                         }];
    
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
                                                         }];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"사진앨범에서 선택하기"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               NSLog(@"You pressed button three");
                                                               
                                                               [self checkLibraryAuthorization];
                                                           }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                           }];
    
    if(![[selectedImageButton currentImage] isEqual:defaultImage]){
        [alert addAction:showAction];
    }
    
    [alert addAction:takeAction];
    [alert addAction:selectAction];
    [alert addAction:cancelAction];
    
    
    [self presentViewController:alert animated:YES completion:nil]; // 6
}

#pragma imagePickerView delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    controller = [[ImageCropViewController alloc] initWithImage:[info valueForKey:UIImagePickerControllerOriginalImage]];
    controller.delegate = self;
    controller.blurredBackground = YES;
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

#pragma mark cropView Delegate
-(void)ImageCropViewControllerSuccess:(UIViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    [[MommyRequest sharedInstance] mommyImageUploadApiService:croppedImage success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            NSLog(@"Image Upload data : %@", data);
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSDictionary *result = [data objectForKey:@"result"];
                [_files addObject:[result objectForKey:@"file_name"]];
                [selectedImageButton setTag:_files.count-1];
                [selectedImageButton setImage:croppedImage forState:UIControlStateNormal];
                [selectedImageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
                
            });
        }else{
            NSLog(@"Image Upload Fail");
        }
    } error:^(NSError *error) {
        NSLog(@"Image Upload Fail");
    }];
    
    
    [[self navigationController] popViewControllerAnimated:YES];
    UIView *imageView = selectedImageButton.superview;
    CGPoint buttonRect = selectedImageButton.frame.origin;
    
    /** deleteButton 추가 **/
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonRect.x+selectedImageButton.frame.size.width-15, buttonRect.y-5, 20, 20)];
    //    deleteButton.tag = 1;
    [deleteButton setImage:[UIImage imageNamed:@"contents_bot_photo_delete.png"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView addSubview:deleteButton];
}

-(void)ImageCropViewControllerDidCancel:(UIViewController *)controller{
    
}

#pragma mark Library Function

-(void) checkLibraryAuthorization {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if(status == PHAuthorizationStatusAuthorized) { // authorized
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

#pragma mark Image Action
- (void)showImageViewer:(id)sender{
    _imageViewer = [[MultiImageViewController alloc] init];
    
    NSMutableArray *imgArray = [[NSMutableArray alloc] initWithArray: @[_imageButton01.currentImage, _imageButton02.currentImage, _imageButton03.currentImage, _imageButton04.currentImage]];
    
    for(int i = 0 ; i < [imgArray count] ; i++){
        if([(UIImage*)imgArray[i] isEqual:defaultImage]){
            [imgArray removeObject:imgArray[i]];
        }
    }
    
    _imageViewer.imgArray = [[NSArray alloc] initWithArray:imgArray];
    _imageViewer.index = (int)[(UIButton*)sender tag];
    
    [self presentViewController:_imageViewer animated:YES completion:nil];
}


-(void)deleteImage:(id)sender{
    UIButton *seletedButton = (UIButton*)[sender superview].subviews[0];
    [seletedButton setImage:defaultImage forState:UIControlStateNormal];
    [_files removeObjectAtIndex:seletedButton.tag];
    [sender removeFromSuperview];
}

@end
