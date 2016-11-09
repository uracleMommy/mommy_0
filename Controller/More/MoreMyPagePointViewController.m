//
//  MoreMyPagePointViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPagePointViewController.h"

@interface MoreMyPagePointViewController ()

@end

@implementation MoreMyPagePointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pointContainerView.layer.borderColor = [[UIColor colorWithRed:249.0f/255.0f green:105.0f/255.0f blue:78.0f/255.0f alpha:1.0f] CGColor];
    _pointContainerView.layer.borderWidth = 1.0f;
    _pointContainerView.layer.cornerRadius = 16;
    
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
    
    _moreMyPagePointModel = [[MoreMyPagePointModel alloc] init];
    
    [self totalPointBind];
    [self pointListBind : 1];
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 토탈 포인트 바인드
- (void) totalPointBind {
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [[NSDictionary alloc] init];
    
    [[MommyRequest sharedInstance] mommyPointApiService:PointInfo authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
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
            // point_tot
            
//            _lblName.text = [NSString stringWithFormat:@"%@님의 누적 포인트", data[@"result"][@"name"]];
            _lblName.text = [NSString stringWithFormat:@"%@", data[@"result"][@"name"]];

            NSNumber *currencyPoint = [[NSNumber alloc] initWithInt:[data[@"result"][@"point_tot"] intValue]];
            NSNumberFormatter *won_format = [[NSNumberFormatter alloc] init];
            won_format.numberStyle = kCFNumberFormatterDecimalStyle;
            NSString *payment_number = [won_format stringFromNumber:currencyPoint];
            _lblTotalPoint.text = payment_number;
            
            
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

#pragma 포인트 리스트 바인드
- (void) pointListBind : (NSInteger) currentPage {
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", nil];
    
    [[MommyRequest sharedInstance] mommyPointApiService:PointList authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
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
            
            NSArray *resultArray = data[@"result"];
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray) {
                
                NSNumber *point = [NSNumber numberWithInt:[dic[@"amount"] intValue]];
                NSString *name = dic[@"name"];
                NSString * regDttm = dic[@"reg_dttm"];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:point, @"amount", name, @"name", regDttm, @"reg_dttm", nil];
                
                [_moreMyPagePointModel.arrayList addObject:newDic];
            }
            _moreMyPagePointModel.delegate = self;
            _tableView.dataSource = _moreMyPagePointModel;
            _tableView.delegate = _moreMyPagePointModel;
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

#pragma 테이블뷰 맨마지막 셀 도달시 추가 로드
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    
    [self pointListBind:count];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
