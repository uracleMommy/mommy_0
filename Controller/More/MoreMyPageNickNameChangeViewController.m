//
//  MoreMyPageNickNameChangeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageNickNameChangeViewController.h"

@interface MoreMyPageNickNameChangeViewController ()

@end

@implementation MoreMyPageNickNameChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** Navigation Setting **/
    //close Button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    //save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(editInfo) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
    
    _moreMyNickNameChangeModel = [[MoreMyNickNameChangeModel alloc] init];
    _tableView.dataSource = _moreMyNickNameChangeModel;
    _tableView.delegate = _moreMyNickNameChangeModel;
    _guideTextLabel.hidden = YES;
    
    NSString *titleText;
    
    switch (_type) {
        case 0: //이메일
        {
            titleText = @"이메일";
            _basicTextField.text = _valueText;
            [_basicTextField setKeyboardType:UIKeyboardTypeEmailAddress];
            _dropDownTextField.hidden = YES;
            _unitLabel.hidden = YES;
            break;
        }
            
        case 1: //닉네임
        {
            titleText = @"닉네임";
            _basicTextField.text = _valueText;
            [_basicTextField setKeyboardType:UIKeyboardTypeDefault];
            _dropDownTextField.hidden = YES;
            _unitLabel.hidden = YES;
            _guideTextLabel.hidden = NO;
            break;
        }
            
        case 2: //거주지
        {
            titleText = @"거주지";
            _dropDownTextField.text = _valueText;
            _basicTextField.hidden = YES;
            _unitLabel.hidden = YES;
            _pickerData_text = [[NSMutableArray alloc]init];
            
            [[MommyRequest sharedInstance] mommySignInApiService:GetAddress authKey:GET_AUTH_TOKEN parameters:@{} success:^(NSDictionary *data) {
                if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                    _addressCodeDic = [[NSMutableDictionary alloc] init];
                    NSArray *addressArr = [data objectForKey:@"result"];
                    for(int i=0 ; i < [addressArr count] ; i++){
                        [_pickerData_text addObject:[[addressArr objectAtIndex:i] objectForKey:@"address_name"]];
                        [_addressCodeDic setObject:[[addressArr objectAtIndex:i] objectForKey:@"address_code"] forKey:[[addressArr objectAtIndex:i] objectForKey:@"address_name"]];
                    }
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [_dropDownTextField setDropDownMode : IQDropDownModeTextPicker];
                        [_dropDownTextField setItemList:_pickerData_text];
                    });
                    
                }
            } error:^(NSError *error) {
                
            }];
            break;
        }
            
        case 3: //출산예정일
        {
            titleText = @"출산예정일";
            _unitLabel.hidden = YES;
            _basicTextField.hidden = YES;
            [_dropDownTextField setDropDownMode : IQDropDownModeDatePicker];
            _dropDownTextField.text = _valueText;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY.MM.dd"];
            [_dropDownTextField setDateFormatter:formatter];
            [_dropDownTextField setMinimumDate:[NSDate date]];
            [_dropDownTextField setDate:[formatter dateFromString:_valueText]];
            
            break;
        }
            
        case 4: //임신 전 체중
        {
            titleText = @"임신 전 체중";
            _basicTextField.text = [self numberString:_valueText];
            _dropDownTextField.hidden = YES;
            _unitLabel.text = @"kg";
            
            _pickerData_number_point = [[NSMutableArray alloc]init]; //소수점 1자리
            _pickerData_number_weight = [[NSMutableArray alloc]initWithArray:@[@"Select"]]; //체중
            
            for(int i = 0 ; i < 200 ; i++){
                if(i < 10){
                    [_pickerData_number_point addObject: [NSString stringWithFormat:@".%d", i]];
                }else if( i > 20 && i < 100){
                    [_pickerData_number_weight addObject: [NSString stringWithFormat:@"%d", i]];
                }
            }
            
            _pickerView = [[UIPickerView alloc] init];
            _pickerView.dataSource = self;
            _pickerView.delegate = self;
            [_basicTextField setInputView:_pickerView];
            break;
        }
            
        case 5: //현제 체중
        {
            titleText = @"현재 체중";
            _basicTextField.text = [self numberString:_valueText];
            _dropDownTextField.hidden = YES;
            _unitLabel.text = @"kg";
            _pickerData_number_point = [[NSMutableArray alloc]init]; //소수점 1자리
            _pickerData_number_weight = [[NSMutableArray alloc]initWithArray:@[@"Select"]]; //체중
            
            for(int i = 0 ; i < 200 ; i++){
                if(i < 10){
                    [_pickerData_number_point addObject: [NSString stringWithFormat:@".%d", i]];
                }else if( i > 20 && i < 100){
                    [_pickerData_number_weight addObject: [NSString stringWithFormat:@"%d", i]];
                }
            }
            
            _pickerView = [[UIPickerView alloc] init];
            _pickerView.dataSource = self;
            _pickerView.delegate = self;
            [_basicTextField setInputView:_pickerView];

            break;
        }
            
        case 6: //키
        {
            titleText = @"키";
            _dropDownTextField.text = [self numberString:_valueText];
            _basicTextField.hidden = YES;
            _unitLabel.text = @"cm";
            _pickerData_text = [[NSMutableArray alloc]init];
            
            for(int i = 130 ; i < 200 ; i++){
                [_pickerData_text addObject: [NSString stringWithFormat:@"%d", i]];
            }
            
            [_dropDownTextField setDropDownMode : IQDropDownModeTextPicker];
//            [_dropDownTextField set : IQDropDownModeTextPicker];
            [_dropDownTextField setItemList:_pickerData_text];
            break;
        }
            
        default:
            break;
    }
    
    _titleLabel.text = titleText;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editInfo{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    switch (_type) {
        case 0: //이메일
        {
            [param setValue:_basicTextField.text forKey:@"email"];
            break;
        }
            
        case 1: //닉네임
        {
            [param setValue:_basicTextField.text forKey:@"nickname"];
            break;
        }
            
        case 2: //거주지
        {
            [param setValue:[NSNumber numberWithInteger:[[_addressCodeDic objectForKey:[_dropDownTextField text]] intValue]] forKey:@"address"];
            break;
        }
            
        case 3: //출산예정일
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYYMMdd"];
            NSString *baby_birth = [formatter stringFromDate:[_dropDownTextField date]];
            
            [param setValue:baby_birth forKey:@"baby_birth"];
            break;
        }
            
        case 4: //임신전
        {
            [param setValue:[NSNumber numberWithDouble:[_basicTextField.text doubleValue] ] forKey:@"before_weight"];
            break;
        }
            
        case 5: //현재
        {
            [param setValue:[NSNumber numberWithDouble:[_basicTextField.text doubleValue] ] forKey:@"weight"];
            break;
        }
            
        case 6: //키
        {
            [param setValue:[NSNumber numberWithInt:[_dropDownTextField.text intValue] ] forKey:@"height"];
            break;
        }
            
        default:
            break;
    }
    
    [[MommyRequest sharedInstance] mommyMyPageApiService:MyPageUpdateProfile authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        if([[data objectForKey:@"code"] intValue] == 0){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self closeModal];
            });
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:[data objectForKey:@"msg"]
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            });
        }
    } error:^(NSError *error) {
        
    }];
}

- (void)closeModal {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark pikerView

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labelText = [[UILabel alloc] init];
    [labelText setTextAlignment:NSTextAlignmentCenter];
    [labelText setAdjustsFontSizeToFitWidth:YES];
    labelText.backgroundColor = [UIColor clearColor];
    
    if(component == 0){
        if(_type == 4 || _type == 5){
            [labelText setText:_pickerData_number_weight[row]];
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
        [labelText setText:_pickerData_number_point[row]];
        
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
        count = [_pickerData_number_weight count];
    }else{
        count = [_pickerData_number_point count];
    }
 
    return count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableString *value = [[NSMutableString alloc]init];
    if([pickerView selectedRowInComponent:0] != 0){
        [value appendString:[NSString stringWithFormat:@"%@", _pickerData_number_weight[[pickerView selectedRowInComponent:0]]]];
 
        [value appendString:_pickerData_number_point[[pickerView selectedRowInComponent:1]]];
        
        _basicTextField.text = value;
    }
}

- (NSString*)numberString:(NSString *)value
{
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:value.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:value];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return [NSString stringWithString:strippedString];
}


@end
