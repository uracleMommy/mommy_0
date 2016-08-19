//
//  MessageListCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 이미지뷰 원모양으로 바꿈
    _imgProfile.layer.cornerRadius = 25;
    _imgProfile.layer.masksToBounds = YES;
    
    // 컨테이너뷰 라운드, 보더 처리
//    _containerView.layer.borderColor =
//    _containerView.layer.cornerRadius = 5;
    
    
    
    // 점선 표시
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
