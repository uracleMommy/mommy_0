//
//  DiaryListImageCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListImageCustomCell.h"

@implementation DiaryListImageCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cellView.layer setBorderColor:[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.masksToBounds = YES;
    _cellView.layer.cornerRadius = 10;//half of the width
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
