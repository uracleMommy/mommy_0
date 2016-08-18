//
//  DiaryListBasicCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListBasicCustomCell.h"

@implementation DiaryListBasicCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cellView.layer setBorderColor:[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f  blue:153.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:2.0f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
