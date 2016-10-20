//
//  MoreMyPageNickNameChangeViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreMyPageModel.h"
#import "notPasteField.h"

@interface MoreMyPageNickNameChangeViewController : CommonViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreMyNickNameChangeModel *moreMyNickNameChangeModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet notPasteField *defaultTextField;
@property (weak, nonatomic) IBOutlet UILabel *guideTextLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dropDownTextField;
@property (weak, nonatomic) IBOutlet notPasteField *basicTextField;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSString *valueText;

@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (strong, nonatomic) NSMutableArray *pickerData_number_point;
@property (strong, nonatomic) NSMutableArray *pickerData_number_weight;
@property (strong, nonatomic) NSMutableArray *pickerData_text;
@property (strong, nonatomic) NSMutableDictionary *addressCodeDic;
@property (strong, nonatomic) UIPickerView *pickerView;


- (IBAction)closeModal:(id)sender;
- (NSString*)numberString:(NSString *)value;

@end
