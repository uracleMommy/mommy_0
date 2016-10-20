//
//  MoreEquipmentChoiceViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentChoiceViewController.h"
#import "MoreEquipmentSearchingViewController.h"

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
    
    // 현재는 밴드가 없으므로 체중계일때만 처리
    // 체중계일때
    if (indexPath.row == 1) {
        
        [self performSegueWithIdentifier:@"goEquipmentSearching" sender:nil];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goEquipmentSearching"]) {
        
        MoreEquipmentSearchingViewController *moreEquipmentSearchingViewController = (MoreEquipmentSearchingViewController *)segue.destinationViewController;
        moreEquipmentSearchingViewController.deviceKind = SearchDeviceWeight;
    }
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
