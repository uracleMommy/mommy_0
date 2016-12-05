//
//  DiaryDetailListController.m
//  co.medisolution
//
//  Created by uracle on 2016. 10. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryDetailListController.h"
#import "emoticonPopupViewController.h"
#import "ImageCropView.h"
#import "MommyUtils.h"

@interface DiaryDetailListController ()

@end

@implementation DiaryDetailListController
@synthesize selectedImageButton, controller, imagePicker, imagePickerController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Location Manager 생성
    _locationManager = [[CLLocationManager alloc] init];
    
    // Location Receiver 콜백에 대한 delegate 설정
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    // Do any additional setup after loading the view.
    
    _editFlag = NO;
    _cachedImages = [[NSMutableDictionary alloc] init];
    _files = [[NSMutableArray alloc] init];
    
    /** Navigation Setting **/
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    //edit Button Setting
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editBtnImage = [UIImage imageNamed:@"title_icon_edit.png"];
    editBtn.frame = CGRectMake(0, 0, 40, 40);
    [editBtn setImage:editBtnImage forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editDiary) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    //delete Button Setting
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteBtnImage = [UIImage imageNamed:@"title_icon_delete.png"];
    deleteBtn.frame = CGRectMake(0, 0, 40, 40);
    [deleteBtn setImage:deleteBtnImage forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteDiary) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, deleteButton, editButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    /** imageButton Radius, defaultImage Setting **/
    _defaultImage = [UIImage imageNamed:@"contents_btn_photo_update.png"];
    
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
    
    /** Placeholder Setting **/
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, _contentsTextView.frame.size.width - 10.0, 34.0)];
    
    [_placeholderLabel setText:@"내용을 입력해주세요"];
    [_placeholderLabel setBackgroundColor:[UIColor clearColor]];
    [_placeholderLabel setTextColor:[UIColor colorWithRed:199.0/255.0f green:199.0/255.0f  blue:205.0/255.0f alpha:1.0]];
    [_placeholderLabel setFont:[UIFont fontWithName:@"NanumBarunGothic" size:15]];
    _contentsTextView.delegate = self;
    [_contentsTextView addSubview:_placeholderLabel];
    [_contentsTextView setTextContainerInset:UIEdgeInsetsMake(8, -5, 0, 0)];
    _placeholderLabel.hidden = YES;
    
    
    /** PickerView Setting **/
//    _pickerData_0 = [[NSMutableArray alloc]initWithArray:@[@"Select", @"서울시", @"경기도"]];
//    _pickerData_1 = [[NSMutableArray alloc]initWithArray:@[@"Select"]];
//    _pickerData_2 = [[NSMutableArray alloc]initWithArray:@[@"Select"]];
//    
//    _addressPicker = [[UIPickerView alloc] init];
//    _addressPicker.dataSource = self;
//    _addressPicker.delegate = self;
//    [_addressButton setInputView:_addressPicker];
//    
    [_dateButton setDropDownMode:IQDropDownModeDatePicker];
    [_dateButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDateFormatter:formatter];
    [_dateButton setDelegate:self];
//    [_dateButton setDate:NSDate.date];
//    _dateLabel.text = [formatter stringFromDate:NSDate.date];
    
    
    [_timeButton setDropDownMode:IQDropDownModeTimePicker];
    [_timeButton setInputTextFlag:YES];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    [_timeButton setTimeFormatter:formatter2];
    [_timeButton setDelegate:self];
    
//    [_timeButton setDate:NSDate.date];
//    _timeLabel.text = [formatter2 stringFromDate:NSDate.date];
  
    [self initDiary];
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


#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 0){
        switch (buttonIndex) {
            case 1 : {
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setValue:_diaryKey forKey:@"diary_key"];
                
                [self showIndicator];
                [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryDelete authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
                    NSLog(@"PSH data %@", data);
                    
                    NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
                    if([code isEqual:@"0"]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self goBack];
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                            message:@"삭제 도중 오류가 발생하였습니다.\n다시 시도하여주시기 바랍니다."
                                                                           delegate:self
                                                                  cancelButtonTitle:@"취소"
                                                                  otherButtonTitles:nil, nil];
                            [alert show];
                        });
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
                } error:^(NSError *error) {
                    NSLog(@"PSH error %@", error);
                    dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
                }];

                break;
            }
                
            default:
                break;
        }
    }
}


#pragma mark Navigation Button Action
- (void)goBack{
    if(_editFlag){
        [self toDisabled];
        [self initDiary];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)deleteDiary{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                    message:@"다이어리를 삭제하시겠습니까?"
                                                   delegate:self
                                          cancelButtonTitle:@"취소"
                                          otherButtonTitles:@"삭제", nil];
    alert.tag = 0;
    [alert show];
}

- (void)editDiary{
    _editFlag = YES;
    [self toEdit];
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
        [param setValue:_adressLabel.text forKey:@"address_name"];
        [param setValue:emoticon forKey:@"emoticon"];
        [param setValue:reg_dttm forKey:@"reg_dttm"];
        [param setValue:images forKey:@"images"];
        [param setValue:_diaryKey forKey:@"diary_key"];
        
        [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryUpdate authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            NSLog(@"data : %@", data);
            if([code isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self toDisabled];
//                    [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
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

#pragma mark 다이어리 초기화
- (void)initDiary{
    //기본 세팅
    [_imageButton01 setImage:_defaultImage forState:UIControlStateNormal];
    [_imageButton02 setImage:_defaultImage forState:UIControlStateNormal];
    [_imageButton03 setImage:_defaultImage forState:UIControlStateNormal];
    [_imageButton04 setImage:_defaultImage forState:UIControlStateNormal];
    [_files removeAllObjects];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:_diaryKey forKey:@"diary_key"];
    //    if(_result == nil){
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryDetail authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setDiary:[data objectForKey:@"result"]];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
    //    }
}


- (void)setDiary:(NSDictionary *)result{
    NSDictionary *detail = [result objectForKey:@"detail"];
    
    //date
    _dateLabel.text = [self getyyyyMMddeeee:[detail objectForKey:@"reg_dttm"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    [_dateButton setDate:[formatter dateFromString:[self getyyyyMMddeeee:[detail objectForKey:@"reg_dttm"]]]];
    
    _timeLabel.text = [self getHHmm:[detail objectForKey:@"reg_dttm"]];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"HH:mm"];
    [_timeButton setDate:[formatter2 dateFromString:[self getHHmm:[detail objectForKey:@"reg_dttm"]]]];    
    
    //address
    _adressLabel.text = [detail objectForKey:@"address_name"];
    
    //emoticon
    if([detail objectForKey:@"emoticon"] && ![[detail objectForKey:@"emoticon"] isEqual:[NSNull null]] && ![[detail objectForKey:@"emoticon"] isEqualToString:@""]){
        [_emoticonButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"contents_icon_emoticon0%d", ([[detail objectForKey:@"emoticon"] intValue] - 500)]] forState:UIControlStateNormal] ;
        [_emoticonButton setTag:([[detail objectForKey:@"emoticon"] intValue] - 500)];
        
        [_emoticonButton setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [_emoticonButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    //title, contents
    _titleTextField.text = [detail objectForKey:@"title"];
    _contentsTextView.text = [detail objectForKey:@"content"];
    
    //image
    if([result objectForKey:@"files"] && ![[result objectForKey:@"files"] isEqual:[NSNull null]] && ![[result objectForKey:@"files"] isEqual:@""]){
        
        NSArray *files = [result objectForKey:@"files"];
        
        for(int i = 0 ; i<[files count] ; i++){
            NSString *fileImageName = [[files objectAtIndex:i] objectForKey:@"file_name"];
            
            if ([_cachedImages objectForKey:fileImageName] != nil) {
                [_files addObject:fileImageName];
                switch (i) {
                    case 0:
                        [_imageButton01 setImage:[_cachedImages objectForKey:fileImageName] forState:UIControlStateNormal];
//                        [_imageButton01 setTag:_files.count-1];
                        break;
                    case 1:
                        [_imageButton02 setImage:[_cachedImages objectForKey:fileImageName] forState:UIControlStateNormal];
//                        [_imageButton02 setTag:_files.count-1];
                        break;
                    case 2:
                        [_imageButton03 setImage:[_cachedImages objectForKey:fileImageName] forState:UIControlStateNormal];
//                        [_imageButton03 setTag:_files.count-1];
                        break;
                    case 3:
                        [_imageButton04 setImage:[_cachedImages objectForKey:fileImageName] forState:UIControlStateNormal];
//                        [_imageButton04 setTag:_files.count-1];
                        break;
                        
                    default:
                        break;
                }
            }else {
                char const * s = [fileImageName  UTF8String];
                dispatch_queue_t queue = dispatch_queue_create(s, 0);
                dispatch_async(queue, ^{
                    
                    NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@&s=%d", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [[files objectAtIndex:i] objectForKey:@"atch_file_key"], i];
                    
                    UIImage *profileImg = nil;
                    NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                    profileImg = [[UIImage alloc] initWithData:firstImageData];
                    
                    [_cachedImages setValue:profileImg forKey:fileImageName];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_files addObject:fileImageName];
                        switch (i) {
                            case 0:
                                [_imageButton01 setImage:profileImg forState:UIControlStateNormal];
//                                [_imageButton01 setTag:_files.count-1];
                                break;
                            case 1:
                                [_imageButton02 setImage:profileImg forState:UIControlStateNormal];
//                                [_imageButton02 setTag:_files.count-1];
                                break;
                            case 2:
                                [_imageButton03 setImage:profileImg forState:UIControlStateNormal];
//                                [_imageButton03 setTag:_files.count-1];
                                break;
                            case 3:
                                [_imageButton04 setImage:profileImg forState:UIControlStateNormal];
//                                [_imageButton04 setTag:_files.count-1];
                                break;
                                
                            default:
                                break;
                        }
                    });
                });
            }
        }
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
    if(_editFlag){
        if (![textView hasText]) {
            _placeholderLabel.hidden = NO;
        }
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(_editFlag){
        if(![textView hasText]) {
            _placeholderLabel.hidden = NO;
        }
        else{
            _placeholderLabel.hidden = YES;
        }
    }
}

#pragma mark switchMode
- (void)toEdit{
    /** Navigation Setting **/
    self.navigationItem.title = @"다이어리 수정";
    //close Button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItems = @[closeButton];
    
    //save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveDiary) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    NSArray *allTextFields = [self findAllTextFieldsInView:self.view];
    for(int i=0 ; i<[allTextFields count] ; i++){
        [[allTextFields objectAtIndex:i] setUserInteractionEnabled:YES];
    }
    
    /** image XButton add **/
    NSArray *allImageButton = [self findAllTextFieldsInView:_imageButtonMomView];
    for(int i=0 ; i<[allImageButton count] ; i++){
        UIButton *btn = [allImageButton objectAtIndex:i];
        if(![[btn currentImage] isEqual:_defaultImage]){
            UIView *imageView = btn.superview;
            CGPoint buttonRect = btn.frame.origin;
            
            /** deleteButton 추가 **/
            UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonRect.x+btn.frame.size.width-15, buttonRect.y-5, 20, 20)];
                deleteButton.tag = 44;
            [deleteButton setImage:[UIImage imageNamed:@"contents_bot_photo_delete.png"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
            [deleteButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [imageView addSubview:deleteButton];
        }
    }
}

- (void)toDisabled{
    _editFlag = NO;
    /** Navigation Setting **/
    self.navigationItem.title = @"다이어리 상세";
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //edit Button Setting
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editBtnImage = [UIImage imageNamed:@"title_icon_edit.png"];
    editBtn.frame = CGRectMake(0, 0, 40, 40);
    [editBtn setImage:editBtnImage forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editDiary) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    //delete Button Setting
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteBtnImage = [UIImage imageNamed:@"title_icon_delete.png"];
    deleteBtn.frame = CGRectMake(0, 0, 40, 40);
    [deleteBtn setImage:deleteBtnImage forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteDiary) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, deleteButton, editButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    NSArray *allTextFields = [self findAllTextFieldsInView:self.view];
    for(int i=0 ; i<[allTextFields count] ; i++){
        [[allTextFields objectAtIndex:i] setUserInteractionEnabled:NO];
    }
    
    /** image XButton remove **/
    NSArray *allImageButton = [self findAllTextFieldsInView:_imageButtonMomView];
    for(int i=0 ; i<[allImageButton count] ; i++){
        UIButton *btn = [allImageButton objectAtIndex:i];
        if(btn.tag == 44){
            [btn removeFromSuperview];
        }
        
        [[allImageButton objectAtIndex:i] setUserInteractionEnabled:YES];
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
    if(_editFlag){
        
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
        
        if(![[selectedImageButton currentImage] isEqual:_defaultImage]){
            [alert addAction:showAction];
        }
        
        [alert addAction:takeAction];
        [alert addAction:selectAction];
        [alert addAction:cancelAction];
        
        
        [self presentViewController:alert animated:YES completion:nil]; // 6

    }else{
        [self showImageViewer:sender];
    }
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
    deleteButton.tag = 44;
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
        if([(UIImage*)imgArray[i] isEqual:_defaultImage]){
            [imgArray removeObject:imgArray[i]];
        }
    }
    
    _imageViewer.imgArray = [[NSArray alloc] initWithArray:imgArray];
    _imageViewer.index = (int)[(UIButton*)sender tag];

    [self presentViewController:_imageViewer animated:YES completion:nil];
}


-(void)deleteImage:(id)sender{
    UIButton *seletedButton = (UIButton*)[sender superview].subviews[0];
    [seletedButton setImage:_defaultImage forState:UIControlStateNormal];
    [_files removeObjectAtIndex:seletedButton.tag];
    [sender removeFromSuperview];
}

#pragma mark utils
- (NSString *) getyyyyMMddeeee : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"YYYY년 MM월 dd일 EEEE"];
    NSString *yyyymmddeeee = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmddeeee;
}

- (NSString *) getHHmm : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *HHmm = [dateFormatter stringFromDate:dateFromString];
    
    return HHmm;
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x isKindOfClass:[UITextView class]])
            [textfieldarray addObject:x];
        
        if([x isKindOfClass:[UIButton class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
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
    
//    [_locationManager stopUpdatingLocation];
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
                    _adressLabel.text = [[data objectForKey:@"result"] objectForKey:@"fullName"];
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
