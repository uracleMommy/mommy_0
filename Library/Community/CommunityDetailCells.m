//
//  CommunityDetailCells.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityDetailCells.h"

@implementation CommunityDetailCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _replyPersonImage01.layer.cornerRadius = 20;//half of the width
    _replyPersonImage01.layer.masksToBounds = YES;
    _replyPersonImage02.layer.cornerRadius = 20;//half of the width
    _replyPersonImage02.layer.masksToBounds = YES;
    _replyPersonImage03.layer.cornerRadius = 20;//half of the width
    _replyPersonImage03.layer.masksToBounds = YES;
    _replyPersonImage04.layer.cornerRadius = 20;//half of the width
    _replyPersonImage04.layer.masksToBounds = YES;
    _replyPersonImage05.layer.cornerRadius = 20;//half of the width
    _replyPersonImage05.layer.masksToBounds = YES;
    _writerPersonImage.layer.cornerRadius = 20;//half of the width
    _writerPersonImage.layer.masksToBounds = YES;
    _replyPersonButton.layer.cornerRadius = 20;//half of the width
    _replyPersonButton.layer.masksToBounds = YES;
    
    _moreButton.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreButtonAction:(id)sender {
    [_delegate moreButtonAction:self point:CGPointMake(_moreButton.frame.origin.x, self.frame.origin.y + _moreButton.frame.size.height - 10)];
//    NSArray *menuItems =
//    @[
//      [KxMenuItem menuItem:@"멘토추가"
//                    target:self
//                    action:@selector(addMentor:)],
//      
//      [KxMenuItem menuItem:@"삭제"
//                    target:self
//                    action:@selector(deleteMessage:)],
//      ];
//    
//    KxMenuItem *first = menuItems[0];
//    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
//    first.alignment = NSTextAlignmentCenter;
//    
//    [KxMenu showMenuInView:self.contentView.subviews[0]
//                  fromRect:CGRectMake(_moreButton.frame.origin.x, _moreButton.frame.origin.y-10, 0, 0)
//     
//                 menuItems:menuItems];
//    
//    [KxMenu setTarget:self action:@selector(dismissMenu)];
   
}

- (IBAction)showProfilePopupViewAction:(id)sender{
    [_delegate showProfilePopupViewAction:_personKey personNickname:_personNickname];
}
@end
