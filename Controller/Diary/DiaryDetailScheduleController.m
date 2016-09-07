//
//  DiaryDetailScheduleController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryDetailScheduleController.h"

@interface DiaryDetailScheduleController ()

@end

@implementation DiaryDetailScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    //edit Button Setting
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editBtnImage = [UIImage imageNamed:@"title_icon_edit.png"];
    editBtn.frame = CGRectMake(0, 0, 40, 40);
    [editBtn setImage:editBtnImage forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editSchedule) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    //delete Button Setting
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteBtnImage = [UIImage imageNamed:@"title_icon_delete.png"];
    deleteBtn.frame = CGRectMake(0, 0, 40, 40);
    [deleteBtn setImage:deleteBtnImage forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteSchedule) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: deleteButton, editButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editSchedule {
    
}

- (void)deleteSchedule {
    
}

@end
