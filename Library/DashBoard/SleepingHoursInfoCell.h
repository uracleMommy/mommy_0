//
//  SleepingHoursInfo.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepingHoursInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *firstSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *secondSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *thirdSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *fourthSmallContainerView;

@property (weak, nonatomic) IBOutlet UILabel *firstLblFirstDotLine;

@property (weak, nonatomic) IBOutlet UILabel *secondLblFirstDotLine;

@property (weak, nonatomic) IBOutlet UILabel *thirdLblFirstDotLine;

@end