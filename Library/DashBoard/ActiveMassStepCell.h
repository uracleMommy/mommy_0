//
//  ActiveMassStepCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveMassStepCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *containerBar;

@property (weak, nonatomic) IBOutlet UILabel *lblStep;

@property (weak, nonatomic) IBOutlet UILabel *lblRecStep;

@end
