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
            if (code != 0) {
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
            if (code != 0) {
                
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


@end
