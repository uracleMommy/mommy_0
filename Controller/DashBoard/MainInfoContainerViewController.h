//
//  MainInfoContainerViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainInfoContainerViewDelegate <NSObject>

@required
- (void) moveSleepView;
- (void) moveWeightView;
- (void) moveStepView;

@end

@interface MainInfoContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblDday;
@property (weak, nonatomic) IBOutlet UILabel *momWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *bobyInfoTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *dDayContainerView;
@property (strong, nonatomic) id<MainInfoContainerViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *sleepHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightResultLable;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *kalLabel;

- (IBAction)sleepButtonAction:(id)sender;
- (IBAction)weightButtonAction:(id)sender;
- (IBAction)stepButtonAction:(id)sender;

@end
