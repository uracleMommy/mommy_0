//
//  MoreProfessionalAdviceViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalAdviceViewController.h"

@interface MoreProfessionalAdviceViewController ()

@end

@implementation MoreProfessionalAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentLastPageStatus = NO;
    _moreProfessionalAdviceModel = [[MoreProfessionalAdviceModel alloc] init];
    
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
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_expert"];
    professionButton.frame = CGRectMake(0, 0, 40, 40);
    [professionButton setImage:closeBtnImage forState:UIControlStateNormal];
    [professionButton addTarget:self action:@selector(professionalListAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *adviceItemButton = [[UIBarButtonItem alloc] initWithCustomView:professionButton];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, adviceItemButton]];
    
    [self getAdviceList:1];
}

#pragma 전문가 상담 내역 리스트 가져오기
- (void) getAdviceList : (NSInteger) currentPage {
    
    NSString *auth_key = @"eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJnb2dvanNzIiwic3ViIjoiZ29nb2pzcyIsImV4cCI6MTQ3NjAwNzgyOSwibmFtZSI6IuyhsOyKueyLnSIsImlhdCI6MTQ3NTE0MzgyOX0.Qzl27M2ye-2pfomvsS8W7dQin_404Ds3YkTVYur_2_4";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"0", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", nil];
    
    [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalAdviceList authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
        long code = [data[@"code"] longValue];
        
        // 실패시
        if (code != 0) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        
        NSArray *resultArray = [NSArray arrayWithArray:data[@"result"]];
        
        long totCnt = 0;
        
        // 데이터 형식 만들기
        for (NSDictionary *dic in resultArray) {
            
            NSString *qnaKey = dic[@"qna_key"];
            NSString *adviceContent = dic[@"content"];
            NSString *replyYN = dic[@"reply_yn"];
            NSString *adviceType = dic[@"type"];
            NSString *regDttm = dic[@"reg_dttm"];
            totCnt = [dic[@"tot_cnt"] longValue] ;
            
            NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:qnaKey, @"qna_key", adviceContent, @"content", replyYN, @"reply_yn", adviceType, @"type", regDttm, @"reg_dttm",  nil];
            [_moreProfessionalAdviceModel.arrayList addObject:newDic];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 카운터 없으면 empty 분기
            if (totCnt <= 0) {
                
                _currentLastPageStatus = YES;
                
                // 네비게이션바 버튼 지우기
                
                [self hideIndicator];
                
                if (_currentLastPageStatus && _moreProfessionalAdviceModel.arrayList.count > 0) {
                    return;
                }
                
                [self performSegueWithIdentifier:@"goProfessionalEmpty" sender:nil];
                
                return;
            }
            
            _currentLastPageStatus = NO;
            _moreProfessionalAdviceModel.delegate = self;
            _tableView.dataSource = _moreProfessionalAdviceModel;
            _tableView.delegate = _moreProfessionalAdviceModel;
            [_tableView reloadData];
            
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
    
    _moreProfessionalButtonViewController = [[MoreProfessionalButtonViewController alloc] initWithNibName:@"MoreProfessionalButtonViewController" bundle:nil];
    _moreProfessionalButtonViewController.view.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 85, [[UIScreen mainScreen] applicationFrame].size.height - 65, 85, 85);
    _moreProfessionalButtonViewController.delegate = self;
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_moreProfessionalButtonViewController.view];
}

- (void) professionalButtonStatus:(ProfessionalButtonStatus)professionalButtonStatus {
    
    if (professionalButtonStatus == ProfessionalNormalMode) {
        
        _moreProfessionalButtonViewController.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    else {
        
        _moreProfessionalButtonViewController.view.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 85, [[UIScreen mainScreen] applicationFrame].size.height - 65, 85, 85);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 전문가 리스트 불러오기
- (void) professionalListAction {
    
    [_moreProfessionalButtonViewController.view removeFromSuperview];
    [self performSegueWithIdentifier:@"goProfessionalList" sender:nil];
}

- (void) closeModal {
    [_moreProfessionalButtonViewController.view removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 테이블뷰 셀렉티드 콜백
- (void) tableView:(UITableView *)tableView moreProfessionalSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [_moreProfessionalButtonViewController.view removeFromSuperview];
    [self performSegueWithIdentifier:@"goProfessionalAdviceInfo" sender:nil];
}

#pragma 테이블뷰 더보기 콜백
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count {
    
    [self getAdviceList:count + 1];
}

@end
