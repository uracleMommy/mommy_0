//
//  MoreBloodPressureViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureViewController.h"

@interface MoreBloodPressureViewController ()

@end

@implementation MoreBloodPressureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreBloodPressureModel = [[MoreBloodPressureModel alloc] init];
    _moreBloodPressureModel.arrayList = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    _tableView.dataSource = _moreBloodPressureModel;
    _tableView.delegate = _moreBloodPressureModel;
    
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
    
    // 우측버튼
    UIButton *professionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_add"];
    professionButton.frame = CGRectMake(0, 0, 40, 40);
    [professionButton setImage:closeBtnImage forState:UIControlStateNormal];
    [professionButton addTarget:self action:@selector(addHistory) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *adviceItemButton = [[UIBarButtonItem alloc] initWithCustomView:professionButton];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, adviceItemButton]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) addHistory {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"혈압기록 추가" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 38)];
         aLabel.text = @"수축기 혈압 :";
         //aLabel.font = aField.font;
         aLabel.textColor = [UIColor grayColor];
         
         textField.leftView = aLabel;
         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"mmHg", @"수축기 혈압");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentRight;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         [aLabel setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:13.0f]];
         
     }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         
         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 38)];
         aLabel.text = @"수축기 혈압 :";
         //aLabel.font = aField.font;
         aLabel.textColor = [UIColor grayColor];
         
         textField.leftView = aLabel;
         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"mmHg", @"이완기 혈압");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentRight;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         [aLabel setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:13.0f]];
         
     }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
         aLabel.text = @"맥박(1분 기준) :";
         //aLabel.font = aField.font;
         aLabel.textColor = [UIColor grayColor];
         
         textField.leftView = aLabel;
         textField.leftViewMode = UITextFieldViewModeAlways;
         
         textField.placeholder = NSLocalizedString(@"회", @"맥박");
         [textField setFrame:CGRectMake(0, 0, textField.frame.size.width, 35.0f)];
         textField.textAlignment = NSTextAlignmentRight;
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         [aLabel setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:13.0f]];
     }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // 혈압기록 추가 하기
    }];
    
    [alert addAction:confirmButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
