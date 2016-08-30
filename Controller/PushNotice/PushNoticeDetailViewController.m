//
//  PushNoticeDetailViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "PushNoticeDetailViewController.h"

@interface PushNoticeDetailViewController ()


@end

@implementation PushNoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lblType.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _lblType.layer.borderWidth = 1.0f;
    _lblType.layer.cornerRadius = 12;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
