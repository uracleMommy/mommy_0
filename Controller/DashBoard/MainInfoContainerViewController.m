//
//  MainInfoContainerViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MainInfoContainerViewController.h"

@interface MainInfoContainerViewController ()

@end

@implementation MainInfoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _lblDday.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
//    _lblDday.layer.borderWidth = 1.0f;
//    _lblDday.layer.cornerRadius = 10;
    
    _dDayContainerView.layer.cornerRadius = 19;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sleepButtonAction:(id)sender {
    [_delegate moveSleepView];
}

- (IBAction)weightButtonAction:(id)sender {
    [_delegate moveWeightView];
}

- (IBAction)stepButtonAction:(id)sender {
    [_delegate moveStepView];
}
@end
