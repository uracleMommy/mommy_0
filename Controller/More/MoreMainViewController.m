//
//  MoreMainViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMainViewController.h"

@interface MoreMainViewController ()

@end

@implementation MoreMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreMainModel = [[MoreMainModel alloc] init];
    _moreMainModel.delegate = self;
    _tableView.dataSource = _moreMainModel;
    _tableView.delegate = _moreMainModel;
    
}

#pragma 선택된 테이블 콜백
- (void) selectedIndexPath:(NSInteger)index {
    
    // 마이페이지
    if (index == 0) {
        
        [self performSegueWithIdentifier:@"goMypageManagement" sender:nil];
    }
    
    // 혈압관리
    if (index == 1) {
        
        [self performSegueWithIdentifier:@"goBloodPressure" sender:nil];
    }
    // 주별 체크 리스트
    else if (index == 3) {
        
        [self performSegueWithIdentifier:@"goWeekCheckList" sender:nil];
    }
    // 전문가 상담
    else if (index == 4) {
        
        [self performSegueWithIdentifier:@"goProfessionalAdvice" sender:nil];
    }
    // 기기관리
    else if (index == 5) {
        
        [self performSegueWithIdentifier:@"goEquipmentManagement" sender:nil];        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
