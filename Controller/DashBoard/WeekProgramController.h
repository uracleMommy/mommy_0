//
//  WeekProgramController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"

@interface WeekProgramController : CommonViewController<DZNSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segment;

@end
