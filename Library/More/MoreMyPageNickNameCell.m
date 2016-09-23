//
//  MoreMyPageNickNameCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageNickNameCell.h"

@implementation MoreMyPageNickNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nilSymbol)];
    [_lblNickName addGestureRecognizer:tapGesture];
    
    
}

- (void) touchNickName {
    
    if ([self.delegate respondsToSelector:@selector(NickNameTouch)]) {
        
        [self.delegate NickNameTouch];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
