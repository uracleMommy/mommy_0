//
//  WeightTotalInfoCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightTotalInfoCell.h"

@implementation WeightTotalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    
    // 타이틀 뷰 라운드 처리
//    _titleViewContainer.layer.borderWidth = 1.0f;
    _titleViewContainer.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
