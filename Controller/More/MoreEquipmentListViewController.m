//
//  MoreEquipmentListViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentListViewController.h"

@interface MoreEquipmentListViewController ()

@end

@implementation MoreEquipmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEquipmentListModel = [[MoreEquipmentListModel alloc] init];
    _moreEquipmentListModel.arrayList = _arrayList;
    _tableView.dataSource = _moreEquipmentListModel;
    _tableView.delegate = _moreEquipmentListModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
