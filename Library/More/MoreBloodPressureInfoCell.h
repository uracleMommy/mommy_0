//
//  MoreBloodPressureInfoCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 17..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreBloodPressureInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblWriteTime;

@property (weak, nonatomic) IBOutlet UILabel *lblBlooodPressure;

@property (weak, nonatomic) IBOutlet UILabel *lblPurse;

@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@end
