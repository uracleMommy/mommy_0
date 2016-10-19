//
//  MoreBloodPressureViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreBloodPressureModel.h"

@interface MoreBloodPressureViewController : CommonViewController<MoreBloodPressureModelDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreBloodPressureModel *moreBloodPressureModel;

@property (assign, nonatomic) NSInteger currentPage; // 기본 1

@property (assign, nonatomic) NSInteger totalPage; // 토탈 페이지 갯수

@property (strong, nonatomic) UITextField *txtSystolic; // 수축기 텍스트

@property (strong, nonatomic) UITextField *txtDiastolic; // 이완기 텍스트

@property (strong, nonatomic) UITextField *pulse; // 맥박

@end
