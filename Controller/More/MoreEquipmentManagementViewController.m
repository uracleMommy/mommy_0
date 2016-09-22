//
//  MoreEuipmentManagementViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentManagementViewController.h"

@interface MoreEquipmentManagementViewController ()

@end

@implementation MoreEquipmentManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 데이터 조회해서 데이터가 없으면 분기처리
    
    // 데이터가 있을때
    NSArray *arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
    [self performSegueWithIdentifier:@"goEquipmentList" sender:arrayList];
//    [self performSegueWithIdentifier:@"goEquipmentEmpty" sender:nil];
    
    // 데이터가 없을때
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goEquipmentList"]) {
        
        MoreEquipmentListViewController *controller = (MoreEquipmentListViewController *)segue.destinationViewController;
        controller.arrayList = (NSArray *)sender;        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 기기추가
- (IBAction)addEquipment:(id)sender {
    
    [self performSegueWithIdentifier:@"goAddEquipment" sender:nil];
}

@end
