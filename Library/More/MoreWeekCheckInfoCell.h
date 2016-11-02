//
//  MoreWeekCheckInfoCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreWeekCheckInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentsHeightConstraint;

@end
