//
//  ActiveMassController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassController.h"
#import "ExerciseCountDownController.h"

@interface ActiveMassController ()

@end

@implementation ActiveMassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    [_dayWeekTypeSegment addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    [_dayWeekTypeSegment setFrame:CGRectMake(0, 0, screenSize.size.width, 44)];
    
    _currentPage = 0;
    
    [self getStepDaily : _currentPage];
}

- (void) didChangeSegment : (id) sender {
    
    _currentPage = 0;
    
    // 일자별
    if (_dayWeekTypeSegment.selectedSegmentIndex == 0) {
        
        [self getStepDaily : _currentPage];
    }
    // 주차별
    else {
        
        [self getStepWeekly : _currentPage];
    }
    
}

#pragma 일자별 활동정보 가져오기
- (void) getStepDaily : (NSInteger) currentPage {
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyChartApiService:ChartStepDaily authKey:authToken parameters:parameters success:^(NSDictionary *data) {
        
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
            
            _activeMassModel = [[ActiveMassModel alloc] init];
            _activeMassModel.delegate = self;
            
            // 차트 바인딩
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"daily_step" ofType:@"html"]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            _activeMassModel.chartRequest = request;
            
            // 테이블 리로드
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:data[@"result"]];
            [resultDic setValue:@([UIScreen mainScreen].bounds.size.width - 32) forKey:@"width"];
            [resultDic setValue:@(180) forKey:@"height"];
            
            _activeMassModel.dicList = resultDic;
            _tableView.dataSource = _activeMassModel;
            _tableView.delegate = _activeMassModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 주차별 활동정보 가져오기
- (void) getStepWeekly : (NSInteger) currentPage {
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyChartApiService:ChartStepWeekly authKey:authToken parameters:parameters success:^(NSDictionary *data) {
        
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
            
            _activeMassModel = [[ActiveMassModel alloc] init];
            _activeMassModel.delegate = self;
            
            // 차트 바인딩
            NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"weekly_step" ofType:@"html"]];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
            _activeMassModel.chartRequest = request;
            
            // 테이블 리로드
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:data[@"result"]];
            [resultDic setValue:@([UIScreen mainScreen].bounds.size.width - 32) forKey:@"width"];
            [resultDic setValue:@(180) forKey:@"height"];
            
            _activeMassModel.dicList = resultDic;
            _tableView.dataSource = _activeMassModel;
            _tableView.delegate = _activeMassModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goExerciseTimer:(id)sender {
    
    UIStoryboard *dashBoardStoryboard = [UIStoryboard storyboardWithName:@"DashBoard" bundle:nil];    
    UIViewController *exerciseCountDownController = [dashBoardStoryboard instantiateViewControllerWithIdentifier:@"ExerciseCountDown"];
    
    
    CGRect size = [[UIScreen mainScreen] bounds];
    [exerciseCountDownController.view setFrame:size];
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:exerciseCountDownController.view];
}

#pragma 차트 콜백
- (void) goChartPrevious {
    
    if(_currentPage == 0) {
        
        return;
    }
    
    _currentPage--;
    
    // 일자별
    if (_dayWeekTypeSegment.selectedSegmentIndex == 0) {
        
        [self getStepDaily : _currentPage];
    }
    // 주차별
    else {
        
        [self getStepWeekly:_currentPage];
    }
}

#pragma 차트 콜백
- (void) goChartNext {
    
    _currentPage++;
    
    // 일자별
    if (_dayWeekTypeSegment.selectedSegmentIndex == 0) {
        
        [self getStepDaily : _currentPage];
    }
    // 주차별
    else {
        
        [self getStepWeekly:_currentPage];
    }
}

@end
