//
//  MoreEnvironmentSetupViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEnvironmentSetupViewController.h"

@interface MoreEnvironmentSetupViewController ()

@end

@implementation MoreEnvironmentSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEnvironmentListModel = [[MoreEnvironmentListModel alloc] init];
    _moreEnvironmentListModel.delegate = self;
    _tableView.dataSource = _moreEnvironmentListModel;
    _tableView.delegate = _moreEnvironmentListModel;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logoutButtonAction:(id)sender {
    
}

- (void) tableView:(UITableView *)tableView MoreMyPageModelSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"goCalendarConnectList" sender:nil];
}

@end
