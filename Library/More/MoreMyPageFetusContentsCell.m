//
//  MoreMyPageFetusContentsCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageFetusContentsCell.h"

@implementation MoreMyPageFetusContentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteBabyNicknameButton:(id)sender {
    _txtFetusName.text = @"";
    [_delegate deleteBabyNicknameButton:self];
}
@end
