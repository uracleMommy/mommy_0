//
//  MoreMainMenuCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMainMenuCell.h"

@implementation MoreMainMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    
    _firstSmallContainerView.layer.cornerRadius = 10;
    _secondSmallContainerView.layer.cornerRadius = 10;
    _thirdSmallContainerView.layer.cornerRadius = 10;
    _fourthSmallContainerView.layer.cornerRadius = 10;
    _fifthSmallContainerView.layer.cornerRadius = 10;
    _sixthSmallContainerView.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma 혈압관리
- (IBAction)goBloodPressure:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(moreMenuTouchIndex:)]) {
        
        [self.delegate moreMenuTouchIndex:1];
    }
}

#pragma 포인트
- (IBAction)goPoint:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(moreMenuTouchIndex:)]) {
        
        [self.delegate moreMenuTouchIndex:2];
    }
}

#pragma 주차별 체크리스트
- (IBAction)goWeekCheck:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(moreMenuTouchIndex:)]) {
        
        [self.delegate moreMenuTouchIndex:3];
    }
}

#pragma 전문가 상담
- (IBAction)goProfessionalAdvice:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(moreMenuTouchIndex:)]) {
        
        [self.delegate moreMenuTouchIndex:4];
    }
}

#pragma 기기관리
- (IBAction)goEquipmentManagement:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(moreMenuTouchIndex:)]) {
        
        [self.delegate moreMenuTouchIndex:5];
    }
}

#pragma 환경설정
- (IBAction)goEnvironmentSetup:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(moreMenuTouchIndex:)]) {
        
        [self.delegate moreMenuTouchIndex:6];
    }
}

@end
