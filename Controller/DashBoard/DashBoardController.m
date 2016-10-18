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

@interface DashBoardController ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate>

@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self dashboardInfoBind];
    
    //[self performSegueWithIdentifier:@"goQuestionModal" sender:nil];
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
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            }
            
            // 프로그램 리스트 바인드
            _programList = [NSArray arrayWithArray:data[@"result"][@"program_list"]];
            
            // 문진정보 띄우기(제출을 하지 않았으면)
            [self performSegueWithIdentifier:@"goQuestionModal" sender:data[@"result"][@"baby_info"][@"mom_week"]];
            
            // 프로그램 리스트 바인드
            [self programListBind];
            
            // 대쉬보드 정보 바인드
            _dashboardDic = data[@"result"];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error) {
        
        [self hideIndicator];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAlertAction];
        [self presentViewController:alert animated:YES completion:nil];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goQuestionModal"]) {
        
        UINavigationController *navController = segue.destinationViewController;
        QuestionViewController *questionViewController = (QuestionViewController *)navController.viewControllers[0];
        questionViewController.momWeek = [NSNumber numberWithInt:[sender intValue]];
    }
    else if ([segue.identifier isEqualToString:@"goDashboardTotalInfo"]) {
        
        
        NSLog(@"여기");
    }
    else if ([segue.identifier isEqualToString:@"goDashboardProgramInfo"]) {
        
        _mainSliderViewContainerController = segue.destinationViewController;
    }
}

@end










