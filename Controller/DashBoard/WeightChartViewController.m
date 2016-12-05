//
//  WeightChartViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightChartViewController.h"

@interface WeightChartViewController ()

@end

@implementation WeightChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_add"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(addWeightHand) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIButton *weightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *weightBtnImage = [UIImage imageNamed:@"title_icon_weight"];
    weightBtn.frame = CGRectMake(0, 0, 40, 40);
    [weightBtn setImage:weightBtnImage forState:UIControlStateNormal];
    [weightBtn addTarget:self action:@selector(addWeightAuto) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *weightButton = [[UIBarButtonItem alloc] initWithCustomView:weightBtn];
    
    UIPickerView *beforeWeightPicker = [[UIPickerView alloc] init];
    beforeWeightPicker.dataSource = self;
    beforeWeightPicker.delegate = self;
    

    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton, weightButton]];
    

    
    // 우측버튼
    UIButton *professionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close"];
    professionButton.frame = CGRectMake(0, 0, 40, 40);
    [professionButton setImage:closeBtnImage forState:UIControlStateNormal];
    [professionButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *adviceItemButton = [[UIBarButtonItem alloc] initWithCustomView:professionButton];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, adviceItemButton]];
    
    
    //weight pickerView setting
    _pickerData_number_point = [[NSMutableArray alloc]init]; //소수점 1자리
    _pickerData_number_weight = [[NSMutableArray alloc]initWithArray:@[@"Select"]]; //체중
    
    for(int i = 0 ; i < 200 ; i++){
        if(i < 10){
            [_pickerData_number_point addObject: [NSString stringWithFormat:@".%d", i]];
        }else if( i > 20 && i < 100){
            [_pickerData_number_weight addObject: [NSString stringWithFormat:@"%d", i]];
        }
    }
    
    _weightPicker = [[UIPickerView alloc] init];
    _weightPicker.dataSource = self;
    _weightPicker.delegate = self;

    
    NSArray *items = @[@"일자별", @"주차별"];
    _dayWeekTypeSegment.items = items;
    
    _dayWeekTypeSegment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _dayWeekTypeSegment.delegate = self;
    _dayWeekTypeSegment.selectedSegmentIndex = 0;
    
    [_dayWeekTypeSegment setShowsCount:NO];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    
    [_dayWeekTypeSegment setFrame:CGRectMake(0, 0, screenSize.size.width, 44)];
    
    [_dayWeekTypeSegment addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    
    
    // 테이블 바인드
//    NSArray *arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
//    _weightChartModel = [[WeightChartModel alloc] init];
//    _weightChartModel.arrayList = arrayList;
//    
//    _tableView.delegate = _weightChartModel;
//    _tableView.dataSource = _weightChartModel;
    // [_tableView reloadData];
    
    // 체중계 API
    [self.lsBleManager setDebugModeWithPermissions:@"sky"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *weightDic = [userDefault objectForKey:@"pairedWeightScale"];
    
    if (weightDic != nil) {
        
        LSDeviceInfo *lsDevice = [[LSDeviceInfo alloc] init];
        lsDevice.deviceId = weightDic[@"deviceID"];
        lsDevice.broadcastId = weightDic[@"broadcastID"];
        lsDevice.password = weightDic[@"password"];
        lsDevice.protocolType = weightDic[@"protocolType"];
        lsDevice.deviceType = [self stringToDeviceType:weightDic[@"deviceType"]];
        lsDevice.deviceUserNumber = [weightDic[@"deviceUserNumber"] integerValue];
        lsDevice.peripheralIdentifier = weightDic[@"identifier"];
        lsDevice.deviceName = weightDic[@"deviceName"];
        //[_lsBleManager pairWithLsDeviceInfo:lsDevice pairedDelegate:self];
        NSLog(@"페어링 성공 여부 : %d", [_lsBleManager addMeasureDevice:lsDevice]);
    }
    _currentPage = 0;
    
    [self bindDailyWeightChart:_currentPage];
//    [self bindWeeklyWeightChart:0];
}

-(void)bleManagerDidPairedResults:(LSDeviceInfo *)lsDevice pairStatus:(PairedResults)pairStatus {
    
}

-(LSBLEDeviceManager *)lsBleManager {
    
    if (!_lsBleManager) {
        _lsBleManager = [LSBLEDeviceManager defaultLsBleManager];
    }
    
    return _lsBleManager;
}

- (void) selectedSegment : (id) sender {
    
    _currentPage = 0;
    
    if (_dayWeekTypeSegment.selectedSegmentIndex == 0) {
        
        [self bindDailyWeightChart:_currentPage];
    }
    else {
        
        [self bindWeeklyWeightChart:_currentPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma 닫기
- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 일자별 체중 바인드
- (void) bindDailyWeightChart : (NSInteger) startPage {
    
    [self showIndicator];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (long)startPage], @"searchPage", nil];
    
    [[MommyRequest sharedInstance] mommyChartApiService:ChartWeightDailyGraph authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if( code == -100){
                [self.view makeToast:@"데이터가 없습니다"];
                [self hideIndicator];
                return ;
            }else if (code != 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            }
            
            // 실존 데이터만 뽑기
            NSArray *dataArray = data[@"result"][@"weight_list"];
            
            NSMutableArray *arrayList = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in dataArray) {
                
                if ([dic[@"type"] isEqualToString:@"Y"]) {
                    
                    [arrayList addObject:dic];
                }
            }
            
            _weightChartModel = [[WeightChartModel alloc] init];
            _weightChartModel.chartKind = WeightChartDaily;
            _weightChartModel.arrayList = arrayList;
            _weightChartModel.delegate = self;
            _tableView.delegate = _weightChartModel;
            _tableView.dataSource = _weightChartModel;
            
            // 차트 바인딩
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"daily_weight" ofType:@"html"]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            _weightChartModel.chartRequest = request;
            
            // 테이블 리로드
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:data[@"result"]];
            [resultDic setValue:@([UIScreen mainScreen].bounds.size.width - 42) forKey:@"width"];
            [resultDic setValue:@(170) forKey:@"height"];
            
            _weightChartModel.dicList = resultDic;
            [_tableView reloadData];
            
            [self hideIndicator];
            
        });
        
    } error:^(NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 주차별 체중 바인드
- (void) bindWeeklyWeightChart : (NSInteger) startPage {
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (long)startPage], @"searchPage", nil];
    
    [[MommyRequest sharedInstance] mommyChartApiService:ChartWeightWeeklyGraph authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if( code == -100){
                [self.view makeToast:@"데이터가 없습니다"];
                [self hideIndicator];
                return ;
            }else if (code != 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            }
            
            // 실존 데이터만 뽑기
            NSArray *dataArray = data[@"result"][@"weight_list"];
            
            NSMutableArray *arrayList = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in dataArray) {
                
                if ([dic[@"type"] isEqualToString:@"Y"]) {
                    
                    [arrayList addObject:dic];
                }
            }
            
            _weightChartModel = [[WeightChartModel alloc] init];
            _weightChartModel.chartKind = WeightChartWeekly;
            _weightChartModel.arrayList = arrayList;
            _weightChartModel.delegate = self;
            _tableView.delegate = _weightChartModel;
            _tableView.dataSource = _weightChartModel;
            
            
            // 차트 바인딩
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"daily_weight" ofType:@"html"]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            _weightChartModel.chartRequest = request;
            
            // 테이블 리로드
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:data[@"result"]];
            [resultDic setValue:@([UIScreen mainScreen].bounds.size.width - 42) forKey:@"width"];
            [resultDic setValue:@(170) forKey:@"height"];
            
            _weightChartModel.dicList = resultDic;
            [_tableView reloadData];
            
            [self hideIndicator];
            
        });
        
    } error:^(NSError *error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 체중 기록 추가
- (void) addWeightAuto {
    
    
    // 1. 페어링된 체중계가 있는지 체크
    
    // 2. 없으면 체중계 추가하라는 멘트 뿌리기
    
    // 3. 존재할시에 로딩중 이미지 넣고 체중재기
    
    // 4. 맨 마지막 체중만 넣고 나서 데이터 리프래쉬
    
    
    // 1. 페어링된 체중계가 있는지 체크
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *weightDic = [userDefault objectForKey:@"pairedWeightScale"];
    
    // 메세지
    if (weightDic == nil) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"체중계를 연결해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAlertAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }else{
        [self.lsBleManager startDataReceiveService:self];
    }    
    
}

- (void) addWeightHand {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"체중기록 추가" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
//         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 38)];
//         aLabel.text = @"수축기 혈압 :";
//         //aLabel.font = aField.font;
//         aLabel.textColor = [UIColor grayColor];
//         
//         textField.leftView = aLabel;
//         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"kg", @"체중");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentCenter;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         [textField setInputView:_weightPicker];
         
         _weightTextField = textField;
         
     }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        if ([_weightTextField.text isEqualToString:@""]) {

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"입력이 올바르게 되지 않았습니다." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmButton];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *yyyymmdd = [dateFormatter stringFromDate:[NSDate date]];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_weightTextField.text, @"weight", yyyymmdd, @"date", nil];
        
        [self showIndicator];
        
        // 혈압기록 추가 하기
        [[MommyRequest sharedInstance] mommyChartApiService:ChartWeightLogInsert authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                long code = [data[@"code"] longValue];
                
                // 실패시
                if (code != 0) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    [self hideIndicator];
                    return;
                }
                
                [self selectedSegment:nil];
            });
            
        } error:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self hideIndicator];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
            });
            
        }];
    }];
    
    [alert addAction:confirmButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self.lsBleManager stopDataReceiveService];
}

- (void)bleManagerDidReceiveWeightMeasuredData:(LSWeightData*)data device:(LSDeviceInfo *)device {
    
    NSLog(@"데이터 들어옴");
    
    // [self.lsBleManager stopDataReceiveService];
}

-(LSDeviceType)stringToDeviceType:(id)type
{
    int tempType=[type intValue];
    LSDeviceType tempDeviceType;
    switch (tempType)
    {
        case LS_WEIGHT_SCALE: tempDeviceType=LS_WEIGHT_SCALE;  break;
        case LS_FAT_SCALE:tempDeviceType=LS_FAT_SCALE; break;
        case LS_PEDOMETER:tempDeviceType=LS_PEDOMETER;break;
        case LS_SPHYGMOMETER:tempDeviceType=LS_SPHYGMOMETER;break;
        case LS_HEIGHT_MIRIAM:tempDeviceType=LS_HEIGHT_MIRIAM;break;
        case LS_KITCHEN_SCALE:tempDeviceType=LS_KITCHEN_SCALE;break;
        default:
            break;
    }
    return tempDeviceType;
}

#pragma 차트 콜백
- (void) goChartPrevious {
    
    _currentPage++;
    
    // 일자별
    if (_dayWeekTypeSegment.selectedSegmentIndex == 0) {
        
        [self bindDailyWeightChart : _currentPage];
    }
    // 주차별
    else {
        
        [self bindWeeklyWeightChart:_currentPage];
    }
}

#pragma 차트 콜백
- (void) goChartNext {
    
    if(_currentPage == 0) {
        [self.view makeToast:@"가장 최근 데이터입니다"];
        return;
    }
    
    _currentPage--;
    
    // 일자별
    if (_dayWeekTypeSegment.selectedSegmentIndex == 0) {
        
        [self bindDailyWeightChart : _currentPage];
    }
    // 주차별
    else {
        
        [self bindWeeklyWeightChart:_currentPage];
    }
}


#pragma mark pikerView

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labelText = [[UILabel alloc] init];
    [labelText setTextAlignment:NSTextAlignmentCenter];
    [labelText setAdjustsFontSizeToFitWidth:YES];
    labelText.backgroundColor = [UIColor clearColor];
    
    if(component == 0){
        
        [labelText setText:_pickerData_number_weight[row]];
        
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
        
        _weightTextField.text = value;
    }
}


@end
