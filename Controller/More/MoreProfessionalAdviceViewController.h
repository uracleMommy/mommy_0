//
//  MoreProfessionalAdviceViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface MoreProfessionalAdviceViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnAdvice;

@property (weak, nonatomic) IBOutlet UIButton *btnExecersize;

@property (weak, nonatomic) IBOutlet UIButton *btnNutrition;

@property (weak, nonatomic) IBOutlet UILabel *lblExecersize;

@property (weak, nonatomic) IBOutlet UILabel *lblNutrition;

@property (weak, nonatomic) IBOutlet UIView *containerNutritionView; // 영양 버튼 컨테이너

@property (weak, nonatomic) IBOutlet UIView *containerExecersizeView; // 운동 버튼 컨테이너

@property (assign) ProfessionalButtonStatus professionalButtonStatus;

- (IBAction)adviceAction:(id)sender;

- (IBAction)execersizeAction:(id)sender;

- (IBAction)nutritionAction:(id)sender;

- (IBAction)professionalListAction:(id)sender;



@end