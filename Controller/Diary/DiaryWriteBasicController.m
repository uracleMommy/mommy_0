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
    
    // Location Manager 생성
    _locationManager = [[CLLocationManager alloc] init];
    
    // Location Receiver 콜백에 대한 delegate 설정
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
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
    [saveBtn addTarget:self action:@selector(saveDiary) forControlEvents:UIControlEventTouchUpInside];
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
        
    [_emoticonButton setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [_emoticonButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    /** PickerView Setting **/
//    _pickerData_0 = [[NSMutableArray alloc]initWithArray:@[@"Select", @"서울시", @"경기도"]];
//    _pickerData_1 = [[NSMutableArray alloc]initWithArray:@[@"Select"]];
//    _pickerData_2 = [[NSMutableArray alloc]initWithArray:@[@"Select"]];

//    _addressPicker = [[UIPickerView alloc] init];
//    [_addressButton setInputView:_addressPicker];
    
    [_dateButton setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDateFormatter:formatter];
    [_dateButton setDelegate:self];
    [_dateButton setDate:NSDate.date];
    _dateLabel.text = [formatter stringFromDate:NSDate.date];
    
    
    [_timeButton setDropDownMode:IQDropDownModeTimePicker];
    [_timeButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    [_timeButton setTimeFormatter:formatter2];
    [_timeButton setDelegate:self];
    
    [_timeButton setDate:NSDate.date];
    _timeLabel.text = [formatter2 stringFromDate:NSDate.date];
        
    _files = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navigation Button Action
- (void)goBack{
    if(![_titleTextField.text isEqualToString:@""] && ![_contentsTextView.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"작성 중이던 다이어리를 저장하지 않고 이전 화면으로 이동하시겠습니까?."
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"임시저장", @"나가기", nil];
        [alert setTag:0];
        [alert show];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 0){
        switch (buttonIndex) {
            case 1 : {
                [self showIndicator];
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSMutableArray *images = [[NSMutableArray alloc] init];
                
                for(int i = 0 ; i<_files.count ; i++){
                    NSMutableDictionary *imageObj = [[NSMutableDictionary alloc] init];
                    [imageObj setValue:[_files objectAtIndex:i] forKey:@"file_name"];
                    [images addObject:imageObj];
                }
                
                NSDateFormatter *formatterMonth = [[NSDateFormatter alloc]init];
                [formatterMonth setDateFormat:@"YYYYMMdd"];
                NSDateFormatter *formatterTime = [[NSDateFormatter alloc]init];
                [formatterTime setDateFormat:@"HHmm"];
                
                NSString *reg_dttm = [NSString stringWithFormat:@"%@%@", [formatterMonth stringFromDate:_dateButton.date], [formatterTime stringFromDate:_timeButton.date]];
                
                NSString *emoticon;
                emoticon = [NSString stringWithFormat:@"%ld", (long)_emoticonButton.tag+500];
                
                [param setValue:@"N" forKey:@"isvalid"];
                [param setValue:_titleTextField.text forKey:@"title"];
                [param setValue:_contentsTextView.text forKey:@"content"];
                [param setValue:_addressTextField.text forKey:@"address_name"];
                [param setValue:emoticon forKey:@"emoticon"];
                [param setValue:reg_dttm forKey:@"reg_dttm"];
                [param setValue:images forKey:@"images"];
                
                [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
                    NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
                    NSLog(@"data : %@", data);
                    if([code isEqualToString:@"0"]){
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
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
                break;
            }
                
            case 2 : {
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            }
                
            default:
                break;
        }
    }
}

- (void)saveDiary{
    if([_titleTextField.text isEqualToString:@""] || [_contentsTextView.text isEqualToString:@""]){
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
        
        NSDateFormatter *formatterMonth = [[NSDateFormatter alloc]init];
        [formatterMonth setDateFormat:@"YYYYMMdd"];
        NSDateFormatter *formatterTime = [[NSDateFormatter alloc]init];
        [formatterTime setDateFormat:@"HHmm"];
        
        NSString *reg_dttm = [NSString stringWithFormat:@"%@%@", [formatterMonth stringFromDate:_dateButton.date], [formatterTime stringFromDate:_timeButton.date]];
        
        NSString *emoticon;
        emoticon = [NSString stringWithFormat:@"%ld", (long)_emoticonButton.tag+500];
        
        [param setValue:@"Y" forKey:@"isvalid"];
        [param setValue:_titleTextField.text forKey:@"title"];
        [param setValue:_contentsTextView.text forKey:@"content"];
        [param setValue:_addressTextField.text forKey:@"address_name"];
        [param setValue:emoticon forKey:@"emoticon"];
        [param setValue:reg_dttm forKey:@"reg_dttm"];
        [param setValue:images forKey:@"images"];
        
        [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            NSLog(@"data : %@", data);
            if([code isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
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

#pragma mark dateField & timeField
-(void)textField:(IQDropDownTextField*)textField didSelectItem:(NSString*)item{
    NSLog(@"selected : %@", item);
    if([textField isEqual:_dateButton]){
        _dateLabel.text = item;
    }else{
        _timeLabel.text = item;
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

#pragma mark - emoticon
- (IBAction)showEmoticonPopup:(id)sender {
    if (!_emoticonPopupView) {
        _emoticonPopupView = [[emoticonPopupViewController alloc] initWithNibName:@"emoticonPopupViewController" bundle:nil];
        _emoticonPopupView.delegate = self;
        _emoticonPopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }

    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_emoticonPopupView.view];
}

- (void)clickButton:(int)tag {
    NSMutableString *emoticonImageName = [[NSMutableString alloc] initWithString:@"contents_icon_emoticon0"];
    
    [emoticonImageName appendFormat:@"%d", tag];
    [_emoticonButton setImage:[UIImage imageNamed:emoticonImageName] forState:UIControlStateNormal];
    [_emoticonButton setTag:tag];
    
    [_emoticonButton setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
    [_emoticonButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
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

- (IBAction)getGPSAction:(id)sender {
    // Location Manager 생성
//    self.locationManager = [[CLLocationManager alloc] init];
//    
//    // Location Receiver 콜백에 대한 delegate 설정
//    self.locationManager.delegate = self;
//    
//    // 사용중에만 위치 정보 요청
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
     self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // Location Manager 시작하기
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    
    if(_latitude != [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude] || _longitude != [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude]){
        
        _latitude = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
        _longitude = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
        
        [param setObject:[NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude] forKey:@"latitude"];
        [param setObject:[NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude] forKey:@"longitude"];
        [param setObject:@"WGS84" forKey:@"inputCoordSystem"];
        [param setObject:@"json" forKey:@"output"];
        
        
        [[MommyRequest sharedInstance] mommyDiaryApiService:GpsToAddress authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    _addressTextField.text = [[data objectForKey:@"result"] objectForKey:@"fullName"];
                });
                
            }
        } error:^(NSError *error) {
            
        }];
    }
    
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}
@end
