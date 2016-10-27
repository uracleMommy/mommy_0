//
//  ActiveMassCalorieCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveMassCalorieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblCal;

@property (weak, nonatomic) IBOutlet UILabel *lblRecCal;

@property (weak, nonatomic) IBOutlet UIView *containerBar;

@end
