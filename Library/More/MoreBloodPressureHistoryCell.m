//
//  MoreBloodPressureHistoryCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureHistoryCell.h"

@implementation MoreBloodPressureHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
//    _containerView.layer.borderWidth = 1.0f;
//    _containerView.layer.cornerRadius = 10;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) drawRect:(CGRect)rect {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_containerView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.contentView.bounds;
    maskLayer.path  = maskPath.CGPath;
    _containerView.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = self.contentView.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth   = 2.0f;
    borderLayer.strokeColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [_containerView.layer addSublayer:borderLayer];
}

@end
