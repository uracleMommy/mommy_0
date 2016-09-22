//
//  MoreEquipmentChoiceViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentChoiceViewController.h"

@interface MoreEquipmentChoiceViewController ()

@end

@implementation MoreEquipmentChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEquipmentChoiceModel = [[MoreEquipmentChoiceModel alloc] init];
    _moreEquipmentChoiceModel.delegate = self;
    _tableView.dataSource = _moreEquipmentChoiceModel;
    _tableView.delegate = _moreEquipmentChoiceModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma 테이블 선택 콜백
- (void) tableView:(UITableView *)tableView MoreEquipmentChoiceSelectedRow:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"goEquipmentSearching" sender:nil];
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
