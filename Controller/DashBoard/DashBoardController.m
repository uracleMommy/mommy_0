//
//  DashBoardController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DashBoardController.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"
#import "DashBoardScrollCellView.h"
#import "SingleImageViewController.h"
#import "MultiImageViewController.h"
#import "PageImageViewController.h"
#import "QuestionViewController.h"
#import "ProgramMainViewController.h"


@interface DashBoardController ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate, CoachContainerDelegate>

@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.tabBarController.tabBar.translucent = NO;
//    self.navigationController.navigationBar.translucent = NO;
    
    
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bi"]];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2-55), 10, 110, 20)];
    [imgView setImage:[UIImage imageNamed:@"title_bi"]];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    [titleView addSubview:imgView];
    
//    CGFloat verticalOffset = 190;
//    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
//    [imgView setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
//    titleImageView.frame = CGRectMake(0, 0, 50, 20);
    
//    UIImage *image = [UIImage imageNamed:@"title_bi"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];

//    CGRect test = self.navigationController.navigationBar.frame;
//    self.navigationController.navigationBar.
    self.navigationItem.titleView = titleView;
    
    //message Button
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *messageBtnImage = [UIImage imageNamed:@"title_icon_message.png"];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    [messageBtn setImage:messageBtnImage forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(moveToMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *messageButton = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    //alarm Button
    UIButton *alarmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *alarmBtnImage = [UIImage imageNamed:@"title_icon_alarm.png"];
    alarmBtn.frame = CGRectMake(0, 0, 40, 40);
    [alarmBtn setImage:alarmBtnImage forState:UIControlStateNormal];
    [alarmBtn addTarget:self action:@selector(moveToAlarm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *alarmButton = [[UIBarButtonItem alloc] initWithCustomView:alarmBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, alarmButton, messageButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    

    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    if(![[userDefaults objectForKey:@"coachMarkFlag"] isEqual:[NSNull null]] && [[userDefaults objectForKey:@"coachMarkFlag"] isEqualToString:@"Y"]){
        [self dashboardInfoBind];
//    }else{
//        [userDefaults setObject:@"Y" forKey:@"coachMarkFlag"];
//        [userDefaults synchronize];
//        
//        _coachMarkContainerController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachContainerController"];
//        
//        CGRect windowSize = [UIScreen mainScreen].bounds;
//        
//        [_coachMarkContainerController.view setFrame:windowSize];
//        _coachMarkContainerController.delegate = self;
//        
//        //    [self addChildViewController:_coachMarkContainerController];
//        //
//        //    [self.view addSubview:_coachMarkContainerController.view];
//        
//        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [appDelegate.window addSubview:_coachMarkContainerController.view];
//    }
    
    //[self performSegueWithIdentifier:@"goQuestionModal" sender:nil];
}

- (void)startDashBoard{
//    [self dashboardInfoBind];
}

- (void)moveToMessage{
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (void)moveToAlarm{
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"PushNotice" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"PushListNavigation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}


#pragma 대쉬보드 메인정보 바인드
- (void) dashboardInfoBind {
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [[NSDictionary alloc] init];
    
    [[MommyRequest sharedInstance] mommyDashboardApiService:DashboardMain authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
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
            
            // 프로그램 리스트 바인드
            _programList = [NSArray arrayWithArray:data[@"result"][@"program_list"]];
            
            _mainList = [NSDictionary dictionaryWithDictionary:data[@"result"]];
            
            if(_mainInfoContainerViewController != nil){
                
                _mainInfoContainerViewController.momWeekLabel.text = [NSString stringWithFormat:@"%@주", _mainList[@"baby_info"][@"mom_week"]];
                _mainInfoContainerViewController.lblDday.text = [NSString stringWithFormat:@"D-%@", _mainList[@"baby_info"][@"d_day"]];
                _mainInfoContainerViewController.bobyInfoTitleLabel.text = _mainList[@"baby_info"][@"info"];
                _mainInfoContainerViewController.weightLabel.text = [NSString stringWithFormat:@"%@", _mainList[@"weight_info"][@"weight"]];
                _mainInfoContainerViewController.weightResultLable.text = [NSString stringWithFormat:@"%@", _mainList[@"weight_info"][@"result"]];
                _mainInfoContainerViewController.stepLabel.text = [NSString stringWithFormat:@"%@ 걸음", _mainList[@"step_info"][@"total_step"]];
                _mainInfoContainerViewController.kalLabel.text = [NSString stringWithFormat:@"%@ kcal", _mainList[@"step_info"][@"total_step_kal"]];
            }
            
            // 체중평가 바인드
            _weightCode = data[@"result"][@"weight_info"][@"weight_stauts_code"];
            
            // 문진정보 띄우기(제출을 하지 않았으면)
            if(![data[@"result"][@"medical_info"][@"medical_yn"] isEqual:[NSNull null]] && ![data[@"result"][@"medical_info"][@"medical_yn"] isEqualToString:@"Y"]){
                [self performSegueWithIdentifier:@"goQuestionModal" sender:data[@"result"][@"baby_info"][@"mom_week"]];
            }
            
            // 프로그램 리스트 바인드
            [self programListBind];
            
            // 대쉬보드 정보 바인드
            _dashboardDic = data[@"result"];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            if([[userDefaults objectForKey:@"coachMarkFlag"] isEqual:[NSNull null]] && ![[userDefaults objectForKey:@"coachMarkFlag"] isEqualToString:@"Y"]){
                [userDefaults setObject:@"Y" forKey:@"coachMarkFlag"];
                [userDefaults synchronize];
                
                _coachMarkContainerController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoachContainerController"];
                
                CGRect windowSize = [UIScreen mainScreen].bounds;
                
                [_coachMarkContainerController.view setFrame:windowSize];
                _coachMarkContainerController.delegate = self;
                
                //    [self addChildViewController:_coachMarkContainerController];
                //
                //    [self.view addSubview:_coachMarkContainerController.view];
                
                AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.window addSubview:_coachMarkContainerController.view];
            }
            
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

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 프로그램 리스트 바인드
- (void) programListBind {
    
    _mainSliderViewContainerController.programList = _programList;
    [_mainSliderViewContainerController.mainSlider reloadData];
    
}

#pragma 대쉬보드 정보 바인드
- (void) dashboardDetailInfoBind {
    
    
}

#pragma mark OTPageScrollViewDataSource CallBackMethod
- (UIView*)pageScrollView:(OTPageScrollView *)pageScrollView viewForRowAtIndex:(int)index {
    
//    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
//    cell.backgroundColor = [UIColor whiteColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, cell.frame.size.width-40, cell.frame.size.height - 40)];
//    label.text = @"김경록";
//    [cell addSubview:label];
    
    UIViewController *cell = _scrollViewArray[index];
    return cell.view;
}

#pragma mark OTPageScrollViewDelegate CallBackMethod
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView {
    
    return 3;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView {
    
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width - 40, 99);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index {
    
}

#pragma 금주의 프로그램
- (IBAction)WeekProgramAction:(id)sender {
    
    // 체중평가 코드 넘겨주기
    [self performSegueWithIdentifier:@"goModalWeekProgramSegue" sender:_weightCode];
}

#pragma 쪽지리스트 팝업
- (IBAction)MessagePopupAction:(id)sender {
    
    // MessageNaivgation 
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UIViewController *messageNavigationController = (UIViewController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
//    UIViewController *messageController = (UIViewController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
//    UINavigationController *rootNavi = [[UINavigationController alloc] initWithRootViewController:messageController];
    
    messageNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    
//    NSLog(@" 뷰 갯수 : %lu", (unsigned long)messageNavigationController.viewControllers.count);
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
    
    //[self.view addSubview:messageNavigationController.topViewController.view];
    
//    [self.navigationController presentViewController:messageNavigationController.topViewController animated:YES completion:nil];
    
//    [self presentViewController:messageNavigationController.viewControllers[0] animated:YES completion:nil];
}

- (IBAction)SingleImageView:(id)sender {
    
    SingleImageViewController *singleImageViewController = [[SingleImageViewController alloc] initWithNibName:@"SingleImageViewController" bundle:nil];
    
    [self presentViewController:singleImageViewController animated:YES completion:nil];
}


- (IBAction)MultiImageView:(id)sender {
    
    
//    PageImageViewController *pageImageViewController = [[PageImageViewController alloc] initWithNibName:@"PageImageViewController" bundle:nil];
    
    MultiImageViewController *multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
    
    [self presentViewController:multiImageViewController animated:YES completion:nil];
}

#pragma 알림 팝업
- (IBAction)NoticeView:(id)sender {
    
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"PushNotice" bundle:nil];
    UIViewController *messageNavigationController = (UIViewController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"PushListNavigation"];

    
    messageNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    
//    NSLog(@" 뷰 갯수 : %lu", (unsigned long)messageNavigationController.viewControllers.count);
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (IBAction)MessageModal:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(presentMessage)]) {
        
        [self.delegate presentMessage];
    }
}

#pragma 메인 슬라이더 페이지 설정
- (void) setMainSliderPage : (NSInteger) pageIndex {
    
    switch (pageIndex) {
            
        case 0:
            _firstLedBox.hidden = NO;
            _secondLedBox.hidden = YES;
            _thirdLedBox.hidden = YES;
            break;
            
        case 1:
            _firstLedBox.hidden = YES;
            _secondLedBox.hidden = NO;
            _thirdLedBox.hidden = YES;
            break;
            
        case 2:
            _firstLedBox.hidden = YES;
            _secondLedBox.hidden = YES;
            _thirdLedBox.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void) moveSleepView {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"서비스 준비중입니다." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirmAlertAction];
    [self presentViewController:alert animated:YES completion:nil];
//    [self performSegueWithIdentifier:@"sleepViewSegue" sender:self];
}

- (void) moveWeightView {
    [self performSegueWithIdentifier:@"weightViewSegue" sender:self];
}

- (void) moveStepView {
    [self performSegueWithIdentifier:@"stepViewSegue" sender:self];
}

- (void)moveWeekProgram:(NSDictionary *)program {
    // 체중평가 코드 넘겨주기
    [self performSegueWithIdentifier:@"goModalWeekProgramSegue" sender:program];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goQuestionModal"]) {
        
        UINavigationController *navController = segue.destinationViewController;
        QuestionViewController *questionViewController = (QuestionViewController *)navController.viewControllers[0];
        questionViewController.momWeek = [NSNumber numberWithInt:[sender intValue]];
    }
    else if ([segue.identifier isEqualToString:@"goDashboardTotalInfo"]) {
        _mainInfoContainerViewController = segue.destinationViewController;
        _mainInfoContainerViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"goDashboardProgramInfo"]) {
        
        _mainSliderViewContainerController = segue.destinationViewController;
        _mainSliderViewContainerController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"goModalWeekProgramSegue"]) {
        
        UINavigationController *navController = segue.destinationViewController;
        ProgramMainViewController *programMainViewController = (ProgramMainViewController *)navController.viewControllers[0];
        programMainViewController.weightStatusCode = sender[@"weight_code"];
        if([sender[@"program_type"] intValue] == 11){ //건강
            programMainViewController.weekProgramEnabledKind =  WeekProgramEnabledHealth;
        }else if([sender[@"program_type"] intValue] == 12){     //운동
            programMainViewController.weekProgramEnabledKind = WeekProgramEnabledSport;
        }else{
            programMainViewController.weekProgramEnabledKind = WeekProgramEnabledNutrition;
        }
        programMainViewController.programList = _programList;
    }
}

@end










