//
//  SleepingHoursInfo.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SleepingHoursInfoCell.h"

@implementation SleepingHoursInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    _firstSmallContainerView.layer.cornerRadius = 10;
    _secondSmallContainerView.layer.cornerRadius = 10;
    _thirdSmallContainerView.layer.cornerRadius = 10;
    _fourthSmallContainerView.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
