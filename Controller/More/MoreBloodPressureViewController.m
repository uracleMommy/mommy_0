//
//  MoreBloodPressureViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureViewController.h"
#import "MoreBloodPressureChartCell.h"

@interface MoreBloodPressureViewController ()

@end

@implementation MoreBloodPressureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];

    
    // 우측버튼
    UIButton *professionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_add"];
    professionButton.frame = CGRectMake(0, 0, 40, 40);
    [professionButton setImage:closeBtnImage forState:UIControlStateNormal];
    [professionButton addTarget:self action:@selector(addHistory) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *adviceItemButton = [[UIBarButtonItem alloc] initWithCustomView:professionButton];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, adviceItemButton]];
    
    _moreBloodPressureModel = [[MoreBloodPressureModel alloc] init];
    _currentPage = 1;


    // 리스트 조회
    [self bloodPressureBind:_currentPage];
}

#pragma 혈압기록 리스트
- (void) bloodPressureBind : (NSInteger) currentPage {
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"5", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", nil];
    
    [[MommyRequest sharedInstance] mommyBloodPressureApiService:BloodPressureList authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
        _moreBloodPressureModel.arrayList = [[NSMutableArray alloc] init];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirmAlertAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    [self hideIndicator];
                });
                return;
            }
            
            _totalPage = [data[@"result"][@"pres_tot"] integerValue];
            
            NSArray *resultArray = data[@"result"][@"bp_list"];
            [_moreBloodPressureModel.arrayList removeAllObjects];
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray) {
                
                NSString *contentKey = dic[@"pres_key"];
                NSString *resultComment = dic[@"result"];
                NSNumber *diastolic = [NSNumber numberWithInteger:[dic[@"diastolic"] integerValue]];
                NSNumber *systolic = [NSNumber numberWithInteger:[dic[@"systolic"] integerValue]];
                NSNumber *pulse = [NSNumber numberWithInteger:[dic[@"pulse"] integerValue]];
                NSString *writeTime = dic[@"reg_dttm"];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys: contentKey, @"pres_key", resultComment, @"result", diastolic, @"diastolic", systolic, @"systolic", pulse, @"pulse", writeTime, @"reg_dttm", nil];
                
                [_moreBloodPressureModel.arrayList addObject:newDic];
            }
            
            // 차트 바인딩
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blood_pressure" ofType:@"html"]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            _moreBloodPressureModel.chartRequest = request;
            _moreBloodPressureModel.delegate = self;
                        
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:data[@"result"]];
            [resultDic setValue:@([UIScreen mainScreen].bounds.size.width - 52) forKey:@"width"];
            [resultDic setValue:@(180) forKey:@"height"];
            
            _moreBloodPressureModel.dicList = resultDic;
            _tableView.dataSource = _moreBloodPressureModel;
            _tableView.delegate = _moreBloodPressureModel;
            
            [_tableView reloadData];
            
            [self setCurrentChartRange];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) addHistory {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"혈압기록 추가" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 38)];
         aLabel.text = @"수축기 혈압 :";
         //aLabel.font = aField.font;
         aLabel.textColor = [UIColor grayColor];
         
         textField.leftView = aLabel;
         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"mmHg", @"수축기 혈압");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentRight;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         textField.delegate = self;
         
         _txtSystolic = textField;
         
         [aLabel setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:13.0f]];
         
     }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         
         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 38)];
         aLabel.text = @"수축기 혈압 :";
         //aLabel.font = aField.font;
         aLabel.textColor = [UIColor grayColor];
         
         textField.leftView = aLabel;
         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"mmHg", @"이완기 혈압");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentRight;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         textField.delegate = self;
         
         _txtDiastolic = textField;
         
         [aLabel setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:13.0f]];
         
     }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
         aLabel.text = @"맥박(1분 기준) :";
         //aLabel.font = aField.font;
         aLabel.textColor = [UIColor grayColor];
         
         textField.leftView = aLabel;
         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"회", @"맥박");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentRight;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         textField.delegate = self;
         
         _pulse = textField;
         
         [aLabel setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:13.0f]];
     }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // 유효성 체크
        if ([_txtSystolic.text isEqualToString:@""] || [_txtDiastolic.text isEqualToString:@""] || [_pulse.text isEqualToString:@""]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"입력이 올바르게 되지 않았습니다." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmButton];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        NSNumber *numSystolic = [NSNumber numberWithInteger:[_txtSystolic.text integerValue]];
        NSNumber *numDiastolic = [NSNumber numberWithInteger:[_txtDiastolic.text integerValue]];
        NSNumber *numPulse = [NSNumber numberWithInteger:[_pulse.text integerValue]];
        
        NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:numSystolic, @"systolic", numDiastolic, @"diastolic", numPulse, @"pulse", nil];
        
        [self showIndicator];
        
        // 혈압기록 추가 하기
        [[MommyRequest sharedInstance] mommyBloodPressureApiService:BloodPressureInsert authKey:auth_key parameters:parameters success:^(NSDictionary *data){
            
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
                
                // 성공
                // 테이블 리로드
                _currentPage = 1;
                
                // 리스트 조회
                [self bloodPressureBind:_currentPage];
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

#pragma 이전 콜백
- (void) goChartPrevious {
    
    if (_currentPage + 5 >= _totalPage) {
        
        return;
    }
    
    _currentPage += 5;
    
    [self bloodPressureBind:_currentPage];
}

#pragma 이후 콜백
- (void) goChartNext {
    
    if (_currentPage <= 1) {
        
        return;
    }
    
    _currentPage -= 5;
    
    if (_currentPage < 1) {
        
        _currentPage = 1;
    }
    
    [self bloodPressureBind:_currentPage];
    
    // 테이블 차트셀에 접근하여 현재 건수 보여주기
}

#pragma 현재 5건에 대한 현재차트 / 토탈 챠트 수
- (void) setCurrentChartRange {
    
    MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
//    cell.lblLately.text = [NSString stringWithFormat:@"최근 5건(%ld/%ld)", (long)_currentPage + 4 > (long)_totalPage ? (long)_totalPage : (long)_currentPage + 4, (long)_totalPage];
    
    cell.lblLately.text = [NSString stringWithFormat:@"%ld건~%ld건 (총%ld건)", (long)_currentPage, (long)_currentPage + 4 > (long)_totalPage ? (long)_totalPage : (long)_currentPage + 4, (long)_totalPage];
    
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 3;
}

#pragma 삭제 콜백
- (void) tableView:(UITableView *)tableView deleteIndex:(NSInteger)row {
    
    // 삭제처리
    NSDictionary *dic = _moreBloodPressureModel.arrayList[row - 2];
    NSDictionary *parametersDic = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"pres_key"], @"presKey", @"5", @"pageSize", [NSString stringWithFormat:@"%ld", (long)_currentPage], @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyBloodPressureApiService:BloodPressureDelete authKey:[GlobalData sharedGlobalData].authToken parameters:parametersDic success:^(NSDictionary *data) {
        
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
            
            _totalPage = [data[@"result"][@"pres_tot"] integerValue];
            
            NSArray *resultArray = data[@"result"][@"bp_list"];
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray) {
                
                NSString *contentKey = dic[@"pres_key"];
                NSString *resultComment = dic[@"result"];
                NSNumber *diastolic = [NSNumber numberWithInteger:[dic[@"diastolic"] integerValue]];
                NSNumber *systolic = [NSNumber numberWithInteger:[dic[@"systolic"] integerValue]];
                NSNumber *pulse = [NSNumber numberWithInteger:[dic[@"pulse"] integerValue]];
                NSString *writeTime = dic[@"reg_dttm"];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys: contentKey, @"pres_key", resultComment, @"result", diastolic, @"diastolic", systolic, @"systolic", pulse, @"pulse", writeTime, @"reg_dttm", nil];
                
                [_moreBloodPressureModel.arrayList addObject:newDic];
            }
            
            _moreBloodPressureModel.delegate = self;
            _tableView.dataSource = _moreBloodPressureModel;
            _tableView.delegate = _moreBloodPressureModel;
            [_tableView reloadData];
            
            [self setCurrentChartRange];
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
        });
    }];
}

@end


















