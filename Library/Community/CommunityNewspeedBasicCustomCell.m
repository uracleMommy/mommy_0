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
    
    [_cellView.layer setBorderColor:[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.cornerRadius = 10;//half of the width
    _cellView.layer.masksToBounds = YES;
    
    _mentoImageButton.layer.cornerRadius = 20;
    _mentoImageButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreButtonAction:(id)sender{
    [_delegate moreButtonAction:self point:CGPointMake(_moreButton.frame.origin.x, self.frame.origin.y + _moreButton.frame.size.height - 10)];
}

- (IBAction)likeButtonAction:(id)sender {
    NSString *like;
    if([[self likeButtonImage].image isEqual:[UIImage imageNamed:@"contents_comm_icon_like"]]){
        like = @"Y";
    }else{
        like = @"N";
    }
    
    [_delegate likeButtonAction:self like:like type:@"IMAGE"];
}


- (IBAction)moveDetailViewButtonAction:(id)sender {
    [_delegate moveDetailViewButtonAction:_data];
}

- (IBAction)moveWriteMessageViewAction:(id)sender {
    [_delegate moveWriteMessageViewAction:self];
}

- (IBAction)showProfilePopupViewAction:(id)sender {
    [_delegate showProfilePopupViewAction:self];
}
@end
