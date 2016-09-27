//
//  MoreMyPagePointViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPagePointViewController.h"

@interface MoreMyPagePointViewController ()

@end

@implementation MoreMyPagePointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pointContainerView.layer.borderColor = [[UIColor colorWithRed:249.0f/255.0f green:105.0f/255.0f blue:78.0f/255.0f alpha:1.0f] CGColor];
    _pointContainerView.layer.borderWidth = 1.0f;
    _pointContainerView.layer.cornerRadius = 16;
    
    NSArray *arrayList = @[@"1", @"2", @"3", @"4", @"5"];
    
    _moreMyPagePointModel = [[MoreMyPagePointModel alloc] init];
    _moreMyPagePointModel.arrayList = arrayList;
    _tableView.dataSource = _moreMyPagePointModel;
    _tableView.delegate = _moreMyPagePointModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
