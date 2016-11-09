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
    
    //back Button
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *leftBtnImage = [UIImage imageNamed:@"title_icon_back"];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setImage:leftBtnImage forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //add Button
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *rightBtnImage = [UIImage imageNamed:@"title_icon_add"];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setImage:rightBtnImage forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addEquipment) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    

    
    // 데이터 조회해서 데이터가 없으면 분기처리
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *weightDic = [userDefault objectForKey:@"pairedWeightScale"];
    
    
    NSLog(@"PSH : %@", [userDefault objectForKey:@"pairedWeightScale"]);
    if(weightDic != nil){
        
        // 데이터가 있을때
        NSArray *arrayList = [NSArray arrayWithObjects:@"1", nil];
        [self performSegueWithIdentifier:@"goEquipmentList" sender:arrayList];
    }else{
        [self performSegueWithIdentifier:@"goEquipmentEmpty" sender:nil];
    }
    
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

- (void)closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 기기추가
- (void)addEquipment {
    
    [self performSegueWithIdentifier:@"goAddEquipment" sender:nil];
}

@end
