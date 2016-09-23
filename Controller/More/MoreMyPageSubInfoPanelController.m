//
//  MoreMyPageSubInfoPanelController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageSubInfoPanelController.h"
#import "MoreMyPageMasterViewController.h"

@interface MoreMyPageSubInfoPanelController ()

@property (weak, nonatomic) IBOutlet UILabel *lblNickName;

@property (weak, nonatomic) IBOutlet UILabel *lblFetus;

@end

@implementation MoreMyPageSubInfoPanelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *nickNameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickNameChange)];
    UITapGestureRecognizer *fetusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetusTap)];
    
    [_lblNickName addGestureRecognizer:nickNameTap];
    [_lblFetus addGestureRecognizer:fetusTap];
    
    
}

- (void) nickNameChange {
    
    MoreMyPageMasterViewController *parentController = (MoreMyPageMasterViewController *)self.parentViewController;
    [parentController modalNickName];
}

- (void) fetusTap {
    
    MoreMyPageMasterViewController *parentController = (MoreMyPageMasterViewController *)self.parentViewController;
    [parentController modalFetusChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
