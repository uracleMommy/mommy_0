//
//  ActiveMassStepCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassStepCell.h"

@implementation ActiveMassStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    // 컨테이터뷰 라운드, 보더처리
    _containerBar.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerBar.layer.borderWidth = 1.0f;
    _containerBar.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
