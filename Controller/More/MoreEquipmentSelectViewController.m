//
//  MoreEquipmentSelectViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentSelectViewController.h"

@interface MoreEquipmentSelectViewController ()

@end

@implementation MoreEquipmentSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    
    _moreEquipmentSelectModel = [[MoreEquipmentSelectModel alloc] init];
    _moreEquipmentSelectModel.delegate = self;
    _tableView.dataSource = _moreEquipmentSelectModel;
    _tableView.delegate = _moreEquipmentSelectModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView MoreEquipmentChoiceSelectedRow:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"goEquipmentParing" sender:nil];
}

@end
