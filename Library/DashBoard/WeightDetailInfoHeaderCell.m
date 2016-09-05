//
//  WeightDetailInfoHeaderCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightDetailInfoHeaderCell.h"

@implementation WeightDetailInfoHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 보더 레이어 삽입
//    CALayer *topBorder = [CALayer layer];
//    topBorder.frame = CGRectMake(0, 0, 304, 3);
//    topBorder.backgroundColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
//    [_containerView.layer addSublayer:topBorder];
//    
//    CALayer *leftBorder = [CALayer layer];
//    leftBorder.frame = CGRectMake(0, 0, 3, 36.5f);
//    leftBorder.backgroundColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
//    [_containerView.layer addSublayer:leftBorder];
    
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
