//
//  WeekProgramCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekProgramCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblWeek;

@property (weak, nonatomic) IBOutlet UILabel *lblContext;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@end
