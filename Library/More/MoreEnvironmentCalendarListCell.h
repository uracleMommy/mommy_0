//
//  MoreEnvironmentCalendarListCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreEnvironmentCalendarListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *calendarImageView;

@property (weak, nonatomic) IBOutlet UILabel *lblCalendarInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblConnected;

@end
