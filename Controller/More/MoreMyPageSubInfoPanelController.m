//
//  MoreMyPageSubInfoPanelController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageSubInfoPanelController.h"

@interface MoreMyPageSubInfoPanelController ()


@end

@implementation MoreMyPageSubInfoPanelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *nickNameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *emailTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *babyBirthTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *beforeWeightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *weightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *heightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelChange:)];
    UITapGestureRecognizer *fetusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetusTap)];

    [_lblNickName addGestureRecognizer:nickNameTap];
    [_lblEmail addGestureRecognizer:emailTap];
    [_lblAddress addGestureRecognizer:addressTap];
    [_lblBabyBirth addGestureRecognizer:babyBirthTap];
    [_lblBeforeWeight addGestureRecognizer:beforeWeightTap];
    [_lblWeight addGestureRecognizer:weightTap];
    [_lblHeight addGestureRecognizer:heightTap];
    [_lblFetus addGestureRecognizer:fetusTap];    
}


- (void)viewDidAppear:(BOOL)animated{
}

-(void) labelChange:(id)sender{
    MoreMyPageMasterViewController *parentController = (MoreMyPageMasterViewController *)self.parentViewController;
    [parentController modalChangeInfo:[(UIGestureRecognizer *)sender view]];
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
