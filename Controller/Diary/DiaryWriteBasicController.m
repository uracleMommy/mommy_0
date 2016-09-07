//
//  DiaryWriteBasicController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 17..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryWriteBasicController.h"

@interface DiaryWriteBasicController ()

@end

@implementation DiaryWriteBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //TODO keypad remove
    
    defaultImage = [UIImage imageNamed:@"contents_btn_photo_update.png"];
   
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    [_placeholderLabel setFont:[UIFont systemFontOfSize:14.5]];
    _contentsTextView.delegate = self;
    
    [_contentsTextView addSubview:_placeholderLabel];
    
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
    
    
    //close Button Setting
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    //save Button Setting
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveDiary) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    [_dateButton setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDateFormatter:formatter];
    [_dateButton setDelegate:self];
    
    

}

- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveDiary{
    
}

-(void)textField:(IQDropDownTextField*)textField didSelectItem:(NSString*)item{
    _dateLabel.text = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (IBAction)showEmoticonPopup:(id)sender {
    if (!_emoticonPopupView) {
        _emoticonPopupView = [[emoticonPopupViewController alloc] initWithNibName:@"emoticonPopupViewController" bundle:nil];
        _emoticonPopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }

    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_emoticonPopupView.view];
}

#pragma mark - picturebutton action
- (IBAction)mommyPictureButtonAction:(id)sender {
    selectedImageButton = sender;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"사진"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"사진보기"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"PSH picker!!");
    image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    controller = [[ImageCropViewController alloc] initWithImage:image];
    controller.delegate = self;
    controller.blurredBackground = YES;

    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    [[self navigationController] pushViewController:controller animated:YES];
}


#pragma mark cropView Delegate
-(void)ImageCropViewControllerSuccess:(UIViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    image = croppedImage;
    
    [selectedImageButton setImage:image forState:UIControlStateNormal];
    [selectedImageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [[self navigationController] popViewControllerAnimated:YES];
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

#pragma mark 사진보기
- (void)showPicture{
    SingleImageViewController *singleImageViewController = [[SingleImageViewController alloc] initWithNibName:@"SingleImageViewController" bundle:nil];
    
    [self presentViewController:singleImageViewController animated:YES completion:nil];

}

@end
