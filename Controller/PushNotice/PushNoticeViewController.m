//
//  PushNoticeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "PushNoticeViewController.h"
#import "PushNoticeDetailViewController.h"

@interface PushNoticeViewController () 

@property (strong, nonatomic) PushNoticeModel *pushNoticeModel;

@property (assign) BOOL currentLastPageStatus; // 현재 마지막 페이지까지 로드가 되어있는지 여부

@property (strong, nonatomic) UIButton *btnClose;

@end

@implementation PushNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // 테이블 로드
    
    _pushNoticeModel = [[PushNoticeModel alloc] init];
    
    _currentLastPageStatus = NO;
    
    // 우측버튼
    _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close"];
    _btnClose.frame = CGRectMake(0, 0, 40, 40);
    [_btnClose setImage:closeBtnImage forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:_btnClose];
    
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, closeButton]];
    
    [self pushListLoad:1];

}

#pragma mark 알림목록 조회
- (void) pushListLoad : (NSInteger) currentPage {
    
    if(_currentLastPageStatus) {
        
        return;
    }
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyPushNoticeApiService:PushNoticeList authKey:GET_AUTH_TOKEN parameters:parameters success:^(NSDictionary *data){
        
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
        
        NSArray *resultArray = [NSArray arrayWithArray:data[@"result"]];
        
        long totCnt = 0;
        
        // 데이터 형식 만들기
        for (NSDictionary *dic in resultArray) {
            
            NSString *pushKey = dic[@"push_key"];
            NSString *pushContent = dic[@"content"];
            NSString *pushType = dic[@"type"];
            NSString *regDttm = dic[@"reg_dttm"];
            totCnt = [dic[@"tot_cnt"] longValue] ;
            
            NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:pushKey, @"push_key", pushContent, @"content", pushType, @"type", regDttm, @"reg_dttm",  nil];
            [_pushNoticeModel.arrayList addObject:newDic];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 카운터 없으면 empty 분기
            if (totCnt <= 0) {
                
                _currentLastPageStatus = YES;
                
                // 네비게이션바 버튼 지우기
                
                [self hideIndicator];
                
                if (_currentLastPageStatus && _pushNoticeModel.arrayList.count > 0) {
                    return;
                }
                
                [self performSegueWithIdentifier:@"goEmptyMessage" sender:nil];
                
                return;
            }
            
            _currentLastPageStatus = NO;
            _pushNoticeModel.delegate = self;
            _tableView.dataSource = _pushNoticeModel;
            _tableView.delegate = _pushNoticeModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error) {
        
        [self hideIndicator];
    }];
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    if ([segue.identifier isEqualToString:@"goDetail"]) {
        
        NSDictionary *dic = sender;
        
        PushNoticeDetailViewController *pushNoticeDetailViewController = (PushNoticeDetailViewController *)segue.destinationViewController;
        NSString *pushType = @"";
        
        // 체중
        if (![dic[@"type"] isEqual:[NSNull null]] && [dic[@"type"] isEqualToString:@"11"]) {
            
            pushType = @"체중";
        }
        // 활동
        else if(![dic[@"type"] isEqual:[NSNull null]] && [dic[@"type"] isEqualToString:@"12"]) {
            
            pushType = @"활동";
        }
        // 혈압
        else if(![dic[@"type"] isEqual:[NSNull null]] && [dic[@"type"] isEqualToString:@"13"]) {
            
            pushType = @"혈압";
        }
        // 일반
        else {
            
            pushType = @"일반";
        }
        
        pushNoticeDetailViewController.type = pushType;
        pushNoticeDetailViewController.writeTime = dic[@"reg_dttm"];
        pushNoticeDetailViewController.pushTitle = dic[@"content"];
        pushNoticeDetailViewController.content = dic[@"content"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma 테이블뷰 셀렉트 콜백
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _pushNoticeModel.arrayList[indexPath.row];
    
    [self performSegueWithIdentifier:@"goDetail" sender:dic];
}

#pragma 테이블뷰 더보기 콜백
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count {
    
    [self pushListLoad:count + 1];
}

- (IBAction)closeView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
