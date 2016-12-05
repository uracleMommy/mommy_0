//
//  SignUpMommyInfoScrollViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMommyInfoScrollViewController.h"

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
    
    _nicknameValidationArr = [[NSMutableArray alloc] initWithArray:@[@"N", @"N"]];

    pickerData_number_point = [[NSMutableArray alloc]init]; //소수점 1자리
    pickerData_number_weight = [[NSMutableArray alloc]initWithArray:@[@"Select"]]; //체중
    pickerData_number_height = [[NSMutableArray alloc]init]; //키
    pickerData_number_fetus = [[NSMutableArray alloc]init]; //태아 정보
    
    for(int i = 0 ; i < 200 ; i++){
        if(i < 10){
            [pickerData_number_point addObject: [NSString stringWithFormat:@".%d", i]];
            if(i > 0 && i < 6){
                [pickerData_number_fetus addObject: [NSString stringWithFormat:@"%d", i]];
            }
        }else if( i > 20 && i < 100){
            [pickerData_number_weight addObject: [NSString stringWithFormat:@"%d", i]];
        }else if( i > 130){
            [pickerData_number_height addObject: [NSString stringWithFormat:@"%d", i]];
        }
    }
    
    [[MommyRequest sharedInstance] mommySignInApiService:GetAddress authKey:GET_AUTH_TOKEN parameters:@{} success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            pickerData_address = [[NSMutableArray alloc] init];
            _addressCodeDic = [[NSMutableDictionary alloc] init];
            NSArray *addressArr = [data objectForKey:@"result"];
            for(int i=0 ; i < [addressArr count] ; i++){
                [pickerData_address addObject:[[addressArr objectAtIndex:i] objectForKey:@"address_name"]];
                [_addressCodeDic setObject:[[addressArr objectAtIndex:i] objectForKey:@"address_code"] forKey:[[addressArr objectAtIndex:i] objectForKey:@"address_name"]];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_addressTextField setDropDownMode : IQDropDownModeTextPicker];
                [_addressTextField setItemList:pickerData_address];
            });
            
        }
    } error:^(NSError *error) {
        
    }];
    
    
    beforeWeightPicker = [[UIPickerView alloc] init];
    beforeWeightPicker.dataSource = self;
    beforeWeightPicker.delegate = self;
    [beforeWeightPicker selectRow:30 inComponent:0 animated:YES];
    [_beforeWeightTextField setInputView:beforeWeightPicker];
    _beforeWeightTextField.text = @"50.0";
    
    nowWeightPicker = [[UIPickerView alloc] init];
    nowWeightPicker.dataSource = self;
    nowWeightPicker.delegate = self;
    [nowWeightPicker selectRow:30 inComponent:0 animated:YES];
    [_nowWeightTextField setInputView:nowWeightPicker];
    _nowWeightTextField.text = @"50.0";
    
    [_heightTextField setDropDownMode : IQDropDownModeTextPicker];
    [_heightTextField setItemList:pickerData_number_height];
    [_heightTextField setSelectedItem:@"160" animated:NO];
    
//    addressPicker = [[UIPickerView alloc] init];
//    addressPicker.dataSource = self;
//    addressPicker.delegate = self;
//    [_addressTextField setInputView:addressPicker];
    
    [_dueDateTextField setDropDownMode : IQDropDownModeDatePicker];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    [_dueDateTextField setDateFormatter:formatter];
    [_dueDateTextField setMinimumDate:[NSDate date]];
    [_dueDateTextField setMaximumDate:[[NSDate date] dateByAddingTimeInterval:60*60*24*281]];
    
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

    if(component == 0){
        if([pickerView isEqual:beforeWeightPicker] || [pickerView isEqual:nowWeightPicker]){
            [labelText setText:pickerData_number_weight[row]];
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
    
    return labelText;
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 0;
    if(component == 0){
        count = [pickerData_number_weight count];
    }else{
        count = [pickerData_number_point count];
    }
    

    return count;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableString *value = [[NSMutableString alloc]init];

    if([pickerView selectedRowInComponent:0] != 0){
        [value appendString:[NSString stringWithFormat:@"%@", pickerData_number_weight[[pickerView selectedRowInComponent:0]]]];
        
        [value appendString:pickerData_number_point[[pickerView selectedRowInComponent:1]]];
        
        if([pickerView isEqual:beforeWeightPicker]){
            _beforeWeightTextField.text = value;
        }else if([pickerView isEqual:nowWeightPicker]){
            _nowWeightTextField.text = value;
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
    [_delegate callImageView:[(UIButton*)sender currentImage]];
}

-(void)setMommyImage:(UIImage *)croppedImage{
    [_mommyImageButton setImage:croppedImage forState:UIControlStateNormal];
    [_mommyImageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    UIImage *blurImage = [croppedImage blurredImageWithRadius:50 iterations:5.0 tintColor:[UIColor blackColor]];;
    [_mommyBackImageView setImage:blurImage];
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
    [_delegate callLibraryView];
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
    [_delegate callCameraView];
}

- (void)cameraDenied{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"카메라를 이용하려면 카메라 접근이 필요합니다.\n\n단말기의 [설정>개인정보보호>카메라]에서 Mommy의 설정상태를 확인해주세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
    [alert show];
}

#pragma mark UITextField Delegate

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if([textField isEqual:_mommyNameTextField]){    //nickname end editing
        NSString *mommyText = [[NSString alloc] initWithString:_mommyNameTextField.text];
        
        if([mommyText isEqualToString:@""]){    //empty nickname
            [_nicknameValidationArr replaceObjectAtIndex:0 withObject:@"N"];
            [_nicknameValidationArr replaceObjectAtIndex:1 withObject:@"N"];
            _mommyNameValidationLabel.textColor = [UIColor lightGrayColor];
            return YES;
        }
        
        if([mommyText length] > 0 && [mommyText length] < 11){  //nickname length validation OK
            [_nicknameValidationArr replaceObjectAtIndex:0 withObject:@"Y"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _mommyNameValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
                         range:NSMakeRange(0, 5)];
            [_mommyNameValidationLabel setAttributedText: text];
        }else{
            [_nicknameValidationArr replaceObjectAtIndex:0 withObject:@"N"];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: _mommyNameValidationLabel.attributedText];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]
                         range:NSMakeRange(0, 5)];
            [_mommyNameValidationLabel setAttributedText: text];
        }
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:mommyText forKey:@"nickname"];
        
        [[MommyRequest sharedInstance] mommySignInApiService:NickNameDuplicateCheck authKey:nil parameters:param success:^(NSDictionary *data){
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){    //nickname duplicate OK
                [_nicknameValidationArr replaceObjectAtIndex:1 withObject:@"Y"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableAttributedString *text =
                    [[NSMutableAttributedString alloc]
                     initWithAttributedString: _mommyNameValidationLabel.attributedText];
                    
                    [text addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor blackColor]
                                 range:NSMakeRange(7, 8)];
                    [_mommyNameValidationLabel setAttributedText: text];
                });
            }else{
                [_nicknameValidationArr replaceObjectAtIndex:1 withObject:@"N"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableAttributedString *text =
                    [[NSMutableAttributedString alloc]
                     initWithAttributedString: _mommyNameValidationLabel.attributedText];
                    
                    [text addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor redColor]
                                 range:NSMakeRange(7, 8)];
                    [_mommyNameValidationLabel setAttributedText: text];
                });
                
            }
        } error:^(NSError *error) {
            [_nicknameValidationArr replaceObjectAtIndex:1 withObject:@"N"];
            NSLog(@"PSH error %@", error);
        } ];
        
    }
    return YES;
}

@end
