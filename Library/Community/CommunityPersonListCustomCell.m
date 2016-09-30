//
//  CommunityPersonListCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityPersonListCustomCell.h"

@implementation CommunityPersonListCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cellView.layer setBorderColor:[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f  blue:153.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.cornerRadius = 10;//half of the width
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)toggleMentorAction:(id)sender {
    if([_mentorButtonImage.image isEqual:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"]]){
        [_mentorButtonImage setImage:[UIImage imageNamed:@"popup_btn_icon_mentor.png"]];
    }else{
        [_mentorButtonImage setImage:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"]];
    }

}
@end
