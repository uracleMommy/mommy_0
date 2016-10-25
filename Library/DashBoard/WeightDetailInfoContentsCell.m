//
//  WeightDetailInfoContentsCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeightDetailInfoContentsCell.h"

@implementation WeightDetailInfoContentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    
}

@end
