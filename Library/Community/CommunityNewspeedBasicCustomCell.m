//
//  CommunityNewspeedBasicCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityNewspeedBasicCustomCell.h"

@implementation CommunityNewspeedBasicCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_cellView.layer setBorderColor:[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f  blue:153.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.cornerRadius = 10;//half of the width
    _cellView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreButtonAction:(id)sender{
    [_delegate moreButtonAction:self point:CGPointMake(_moreButton.frame.origin.x, self.frame.origin.y + _moreButton.frame.size.height - 10)];
}

- (IBAction)likeButtonAction:(id)sender {
//    [_delegate likeButtonAction:sender];
    if([_likeButtonImage.image isEqual:[UIImage imageNamed:@"contents_comm_icon_like"]]){
        [_likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like_on"]];
    }else{
        [_likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like"]];
    }
}

- (IBAction)moveDetailViewButtonAction:(id)sender {
    [_delegate moveDetailViewButtonAction:sender];
}

- (IBAction)moveWriteMessageViewAction:(id)sender {
    [_delegate moveWriteMessageViewAction:sender];
}

- (IBAction)showProfilePopupViewAction:(id)sender {
    [_delegate showProfilePopupViewAction:sender];
}
@end
