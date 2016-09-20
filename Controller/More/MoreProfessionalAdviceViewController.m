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
    
    // 테이블뷰 바인딩
    
    NSArray *arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    
    _moreProfessionalAdviceModel = [[MoreProfessionalAdviceModel alloc] init];
    _moreProfessionalAdviceModel.delegate = self;
    _moreProfessionalAdviceModel.arrayList = [NSArray arrayWithArray:arrayList];
    _tableView.dataSource = _moreProfessionalAdviceModel;
    _tableView.delegate = _moreProfessionalAdviceModel;
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

- (IBAction)professionalListAction:(id)sender {
    
    [_moreProfessionalButtonViewController.view removeFromSuperview];
    [self performSegueWithIdentifier:@"goProfessionalList" sender:nil];
}

- (IBAction)closeView:(id)sender {
    [_moreProfessionalButtonViewController.view removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 테이블뷰 셀렉티드 콜백
- (void) tableView:(UITableView *)tableView moreProfessionalSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [_moreProfessionalButtonViewController.view removeFromSuperview];
    [self performSegueWithIdentifier:@"goProfessionalAdviceInfo" sender:nil];
}

@end
