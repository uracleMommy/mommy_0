//
//  MoreMyPageFetusHeaderCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageFetusHeaderCell.h"

@implementation MoreMyPageFetusHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _txtFetusCount.keyboardDistanceFromTextField = 150;
    
    [_txtFetusCount setItemList:@[@"1명", @"2명", @"3명", @"4명", @"5명"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
