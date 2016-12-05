//
//  WeightChartViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 1..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"
#import "WeightChartModel.h"
#import "CommonViewController.h"
#import <LifesenseBluetooth/LSBLEDeviceManager.h>
#import <LifesenseBluetooth/LSBLEInfoManager.h>
#import <LifesenseBluetooth/LSBleConnector.h>
#import <LifesenseBluetooth/LSSleepRecord.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "UIView+Toast.h"

@interface WeightChartViewController : CommonViewController<DZNSegmentedControlDelegate, LSBleDataReceiveDelegate, LSBlePairingDelegate, WeightChartModelDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong) LSBLEDeviceManager *lsBleManager;

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *dayWeekTypeSegment;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) WeightChartModel *weightChartModel;

@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSMutableArray *pickerData_number_point; //소수점 1자리

@property (strong, nonatomic) NSMutableArray *pickerData_number_weight; //체중

@property (strong, nonatomic) UIPickerView *weightPicker;

@property (strong, nonatomic) UITextField *weightTextField;



@end
