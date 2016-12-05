//
//  MoreProfessionalWriteAdviceController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalWriteAdviceController.h"
#import "MoreProfessionalDetailViewController.h"
#import "MoreProfessionalAdviceViewController.h"

@interface MoreProfessionalWriteAdviceController ()

@end

@implementation MoreProfessionalWriteAdviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 좌측버튼
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"title_icon_save"];
    saveButton.frame = CGRectMake(0, 0, 40, 40);
    [saveButton setImage:saveImage forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveRequestAdvice) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItemButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, saveItemButton]];
    
    // 우측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:backBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goPrevious) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItemButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, backItemButton]];

    /** imageButton Radius, defaultImage Setting **/
    defaultImage = [UIImage imageNamed:@"contents_btn_photo_update.png"];
    _files = [[NSMutableArray alloc] init];
    _imageFiles = [[NSMutableArray alloc] init];
    
    
    _imageButton01.layer.cornerRadius = 20;//half of the width
    _imageButton01.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton01.layer.borderWidth = 2.0f;
    _imageButton01.layer.masksToBounds = YES;
//    [_imageButton01 setImage:_defaultImage forState:UIControlStateNormal];
    
    _imageButton02.layer.cornerRadius = 20;//half of the width
    _imageButton02.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton02.layer.borderWidth = 2.0f;
    _imageButton02.layer.masksToBounds = YES;
    //    [_imageButton02 setImage:_defaultImage forState:UIControlStateNormal];
    
    _imageButton03.layer.cornerRadius = 20;//half of the width
    _imageButton03.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton03.layer.borderWidth = 2.0f;
    _imageButton03.layer.masksToBounds = YES;
    //    [_imageButton03 setImage:_defaultImage forState:UIControlStateNormal];
    
    _imageButton04.layer.cornerRadius = 20;//half of the width
    _imageButton04.layer.borderColor = [UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor;
    _imageButton04.layer.borderWidth = 2.0f;
    _imageButton04.layer.masksToBounds = YES;
    //    [_imageButton04 setImage:_defaultImage forState:UIControlStateNormal];
    
    if(_professionalButtonKind == ProfessionalButtonExecersize){
        self.navigationController.title = @"상담내용등록(운동)";
    }else{
        self.navigationController.title = @"상담내용등록(영양)";
    }
    

    
    // 업데이트 모드일때 실행되는 코드
//    NSLog(@"%@", _qnaKey);
    if (_professionalQuestionWriteUpdateMode == ProfessionalQuestionUpdateMode) {
        
        [self bindUpdateMode];
    }
    
    
}

#pragma 뒤로가기
- (void) goPrevious {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma 상담요청 게시물 저장
- (void) saveRequestAdvice {
    
    // 글쓰기
    if (_professionalQuestionWriteUpdateMode == ProfessionalQuestionWriteMode) {
        
        // 유효성 체크
        if ([_txtContent.text isEqualToString:@""]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"내용을 입력해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        NSString *auth_key = [GlobalData sharedGlobalData].authToken;
        
        NSMutableArray *imageArrayList  = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < _files.count; i++) {
            
            [imageArrayList addObject:[NSDictionary dictionaryWithObjectsAndKeys:_files[i], @"file_name", nil]];
        }
        
        NSDictionary *parameters;
        
        if (_files.count > 0) {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:_txtContent.text, @"content", (_professionalButtonKind == ProfessionalButtonExecersize ? @"11" : @"12"), @"type",  imageArrayList, @"images", nil];
        }
        else {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:_txtContent.text, @"content", (_professionalButtonKind == ProfessionalButtonExecersize ? @"11" : @"12"), @"type", nil];
        }
        
        [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalAdviceContentInsert authKey:auth_key parameters:parameters success:^(NSDictionary *data) {
            
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                if (data == nil) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    return;
                }
                
                long code = [data[@"code"] longValue];
                
                // 실패시
                if (code != 0) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    return;
                }
                
                NSArray *viewList = self.navigationController.viewControllers;
                MoreProfessionalAdviceViewController *moreProfessionalAdviceViewController = viewList[viewList.count - 2];
                moreProfessionalAdviceViewController.afterCUDYN = @"Y";
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
            NSLog(@"%@", data);
            
        } error:^(NSError *error){
            
            NSLog(@"%@", error);
        }];
    }
    // 수정하기
    else {
        
        // 유효성 체크
        if ([_txtContent.text isEqualToString:@""]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"내용을 입력해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        NSString *auth_key = [GlobalData sharedGlobalData].authToken;
        
        NSMutableArray *imageArrayList  = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < _files.count; i++) {
            
            [imageArrayList addObject:[NSDictionary dictionaryWithObjectsAndKeys:_files[i], @"file_name", nil]];
        }
        
        NSDictionary *parameters;
        
        if (_files.count > 0) {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:_txtContent.text, @"content", imageArrayList, @"images", _qnaKey, @"qna_key", nil];
        }
        else {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:_txtContent.text, @"content", _qnaKey, @"qna_key", nil];
        }
        
        [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalAdviceContentUpdate authKey:auth_key parameters:parameters success:^(NSDictionary *data) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                if (data == nil) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    return;
                }
                
                long code = [data[@"code"] longValue];
                
                // 실패시
                if (code != 0) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    return;
                }
                
                NSArray *viewList = self.navigationController.viewControllers;
                MoreProfessionalDetailViewController *moreProfessionalDetailViewController = viewList[viewList.count - 2];
                moreProfessionalDetailViewController.afterCUDYN = @"Y";
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
            NSLog(@"%@", data);
            
        } error:^(NSError *error){
            
            NSLog(@"%@", error);
        }];
    }
}

#pragma 업데이트 모드일때 바인드
- (void) bindUpdateMode {
    
    // 0. 디테일 정보 가져오기
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_qnaKey, @"qna_key", nil];
    
    [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalAdviceDetail authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
        long code = [data[@"code"] longValue];
        
        // 실패시
        if (code != 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            });
        }
        
        // 1. 이미지 바인드
        if ([data[@"result"][@"files"] isKindOfClass:[NSArray class]]) {
            
            NSArray *imageList = [NSArray arrayWithArray:data[@"result"][@"files"]];
            
            for (NSDictionary *imageInfoDic in imageList) {
                
                NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], imageInfoDic[@"atch_file_key"]];
                
                UIImage *profileImg = nil;
                NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                profileImg = [[UIImage alloc] initWithData:firstImageData];
                [_files addObject:imageInfoDic[@"file_name"]];
                [_imageFiles addObject:profileImg];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            int i = 0;
            
            for (UIImage *image in _imageFiles) {
                
                if (i == 0) {
                    
                    [_imageButton01 setTag:i];
                    [_imageButton01 setImage:image forState:UIControlStateNormal];
                    [_imageButton01.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    
                    UIView *imageView = _imageButton01.superview;
                    CGPoint buttonRect = _imageButton01.frame.origin;
                    
                    /** deleteButton 추가 **/
                    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonRect.x+_imageButton01.frame.size.width-15, buttonRect.y-5, 20, 20)];
                    //    deleteButton.tag = 1;
                    [deleteButton setImage:[UIImage imageNamed:@"contents_bot_photo_delete.png"] forState:UIControlStateNormal];
                    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
                    [deleteButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
                    [imageView addSubview:deleteButton];
                }
                else if (i == 1) {
                    
                    [_imageButton02 setTag:i];
                    [_imageButton02 setImage:image forState:UIControlStateNormal];
                    [_imageButton02.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    
                    UIView *imageView = _imageButton02.superview;
                    CGPoint buttonRect = _imageButton02.frame.origin;
                    
                    /** deleteButton 추가 **/
                    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonRect.x+_imageButton02.frame.size.width-15, buttonRect.y-5, 20, 20)];
                    //    deleteButton.tag = 1;
                    [deleteButton setImage:[UIImage imageNamed:@"contents_bot_photo_delete.png"] forState:UIControlStateNormal];
                    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
                    [deleteButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
                    [imageView addSubview:deleteButton];
                }
                
                else if (i == 2) {
                    
                    [_imageButton03 setTag:i];
                    [_imageButton03 setImage:image forState:UIControlStateNormal];
                    [_imageButton03.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    
                    UIView *imageView = _imageButton03.superview;
                    CGPoint buttonRect = _imageButton03.frame.origin;
                    
                    /** deleteButton 추가 **/
                    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonRect.x+_imageButton03.frame.size.width-15, buttonRect.y-5, 20, 20)];
                    //    deleteButton.tag = 1;
                    [deleteButton setImage:[UIImage imageNamed:@"contents_bot_photo_delete.png"] forState:UIControlStateNormal];
                    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
                    [deleteButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
                    [imageView addSubview:deleteButton];
                }
                else {
                    
                    [_imageButton04 setTag:i];
                    [_imageButton04 setImage:image forState:UIControlStateNormal];
                    [_imageButton04.imageView setContentMode:UIViewContentModeScaleAspectFill];
                    
                    UIView *imageView = _imageButton04.superview;
                    CGPoint buttonRect = _imageButton04.frame.origin;
                    
                    /** deleteButton 추가 **/
                    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonRect.x+_imageButton04.frame.size.width-15, buttonRect.y-5, 20, 20)];
                    //    deleteButton.tag = 1;
                    [deleteButton setImage:[UIImage imageNamed:@"contents_bot_photo_delete.png"] forState:UIControlStateNormal];
                    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
                    [deleteButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
                    [imageView addSubview:deleteButton];
                }
                
                i++;
            }
            
            // 2. 컨텐츠 바인드
            
            if (data[@"result"][@"detail"][@"content"] != [NSNull null]) {
                
                _txtContent.text = data[@"result"][@"detail"][@"content"];
            }
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error) {
        
        [self hideIndicator];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAlertAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
    // 2. 이미지 바인드
    
    // 3.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    
    /** deleteButton이 존재 시 삭제 **/
    //    if([imageView.subviews count] > 1){
    //        for(int i = 0 ; i < [imageView.subviews count] ; i++){
    //            if(imageView.subviews[i].tag == 1){
    //                [imageView.subviews[i] removeFromSuperview];
    //            }
    //        }
    //    }
   
    
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

- (void) deleteImage:(id)sender{
    UIButton *seletedButton = (UIButton*)[sender superview].subviews[0];
    [seletedButton setImage:defaultImage forState:UIControlStateNormal];
    [_files removeObjectAtIndex:seletedButton.tag];
    [sender removeFromSuperview];
}

@end
