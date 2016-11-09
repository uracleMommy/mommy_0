//
//  ProgramMainViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ProgramMainViewController.h"
#import "WeekProgramController.h"
#import "WeekProgramSearchViewController.h"

@interface ProgramMainViewController ()

@end

@implementation ProgramMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_search"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
    
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
    
    NSArray *items = @[@"건강", @"운동", @"영양"];
    _programSegment.items = items;
    
    _programSegment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _programSegment.selectedSegmentIndex = 0;
    
    [_programSegment setShowsCount:NO];
    
    [_programSegment addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    [_programSegment setFrame:CGRectMake(0, 0, screenSize.size.width, 44)];
    
    if(_weekProgramEnabledKind == WeekProgramEnabledHealth){
        [self programHealthDetailInfo];
    }else if(_weekProgramEnabledKind == WeekProgramEnabledSport){
        [self programSportsDetailInfo];
        _programSegment.selectedSegmentIndex = 1;
    }else{
        [self programNutritionDetailInfo];
        _programSegment.selectedSegmentIndex = 2;
    }
}

#pragma 주차별 건강 상세 정보
- (void) programHealthDetailInfo {
    
    NSDictionary *parameterDic;
    
    for (NSDictionary *dic in _programList) {
        
        // 건강
        if([dic[@"program_type"] isEqualToString:@"11"]) {
            
            parameterDic = dic;
            break;
        }
    }
    
    if (parameterDic == nil) {
        
        return;
    }
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:parameterDic[@"program_seq"], @"program_seq", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyWeekProgramApiService:WeekProgramHealthDetailInfo authKey:authToken parameters:parameters success:^(NSDictionary *data){
        
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
            
            // html 바인딩
            NSString *htmlResult = [[data[@"result"][@"html"] class] isEqual:[NSNull class]] ? @"" : data[@"result"][@"html"];
            
            if (![htmlResult isEqualToString:@""]) {
                
                NSString *path = [NSString stringWithFormat:@"%@%@", _mainDomain, htmlResult];
                NSURL *url = [[NSURL alloc] initWithString:path];
                NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
                [_webView loadRequest:request];
            }
            
            [self hideIndicator];
        });
    } error:^(NSError *error){
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 주차별 운동 상세 정보
- (void) programSportsDetailInfo {
    
    NSDictionary *parameterDic;
    
    for (NSDictionary *dic in _programList) {
        
        // 건강
        if([dic[@"program_type"] isEqualToString:@"12"]) {
            
            parameterDic = dic;
            break;
        }
    }
    
    if (parameterDic == nil) {
        
        return;
    }
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:parameterDic[@"program_seq"], @"program_seq", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyWeekProgramApiService:WeekProgramSportsDetailInfo authKey:authToken parameters:parameters success:^(NSDictionary *data){
        
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
            
            // html 바인딩
            NSString *htmlResult = [[data[@"result"][@"html"] class] isEqual:[NSNull class]] ? @"" : data[@"result"][@"html"];
            
            if (![htmlResult isEqualToString:@""]) {
                
                NSString *path = [NSString stringWithFormat:@"%@%@", _mainDomain, htmlResult];
                NSURL *url = [[NSURL alloc] initWithString:path];
                NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
                [_webView loadRequest:request];
            }
            
            [self hideIndicator];
        });
    } error:^(NSError *error){
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 주차별 영양 상세 정보
- (void) programNutritionDetailInfo {
    
    NSDictionary *parameterDic;
    
    for (NSDictionary *dic in _programList) {
        
        // 건강
        if([dic[@"program_type"] isEqualToString:@"13"]) {
            
            parameterDic = dic;
            break;
        }
    }
    
    if (parameterDic == nil) {
        
        return;
    }
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:parameterDic[@"program_seq"], @"program_seq", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyWeekProgramApiService:WeekProgramNutritionDetailInfo authKey:authToken parameters:parameters success:^(NSDictionary *data){
        
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
            
            // html 바인딩
            NSString *htmlResult = [[data[@"result"][@"html"] class] isEqual:[NSNull class]] ? @"" : data[@"result"][@"html"];
            
            if (![htmlResult isEqualToString:@""]) {
                
                NSString *path = [NSString stringWithFormat:@"%@%@", _mainDomain, htmlResult];
                NSURL *url = [[NSURL alloc] initWithString:path];
                NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
                [_webView loadRequest:request];
            }
            
            [self hideIndicator];
        });
    } error:^(NSError *error){
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 검색화면으로 이동
- (void) goSearch {
    
    [self performSegueWithIdentifier:@"weekProgramSearchSegue" sender:nil];
}

#pragma 모달창 닫기
- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didChangeSegment : (id) sender {
    
    // 건강
    if(_programSegment.selectedSegmentIndex == 0) {
        
        [self programHealthDetailInfo];
    }
    // 운동
    else if (_programSegment.selectedSegmentIndex == 1) {
        
        [self programSportsDetailInfo];
    }
    // 영양
    else {
        
        [self programSportsDetailInfo];
    }
}

- (IBAction)weekProgramListAction:(id)sender {
    
    [self performSegueWithIdentifier:@"goWeekProgramListSegue" sender:@(_programSegment.selectedSegmentIndex)];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goWeekProgramListSegue"]) {
        
        WeekProgramController *weekProgramController = (WeekProgramController *)segue.destinationViewController;
        weekProgramController.mainSelectedIndex = [sender integerValue] ;
        weekProgramController.weightStatusCode = _weightStatusCode;
        
        if (_programSegment.selectedSegmentIndex == 0) {
            
            weekProgramController.weekProgramEnabledKind = WeekProgramEnabledHealth;
        }
        else if (_programSegment.selectedSegmentIndex == 1) {
            
            weekProgramController.weekProgramEnabledKind = WeekProgramEnabledSport;
        }
        else {
            
            weekProgramController.weekProgramEnabledKind = WeekProgramEnabledNutrition;
        }
        
        
    }
    else if ([segue.identifier isEqualToString:@"weekProgramSearchSegue"]) {
        
        WeekProgramSearchViewController *weekProgramSearchViewController = (WeekProgramSearchViewController *)segue.destinationViewController;
        weekProgramSearchViewController.weightStatusCode = _weightStatusCode;
        if (_programSegment.selectedSegmentIndex == 0) {
            
            weekProgramSearchViewController.weekProgramEnabledKind = WeekProgramEnabledHealth;
        }
        else if (_programSegment.selectedSegmentIndex == 1) {
            
            weekProgramSearchViewController.weekProgramEnabledKind = WeekProgramEnabledSport;
        }
        else {
            
            weekProgramSearchViewController.weekProgramEnabledKind = WeekProgramEnabledNutrition;
        }
    }
}

@end
