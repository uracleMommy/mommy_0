//
//  EnumType.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#ifndef EnumType_h
#define EnumType_h

#pragma 쪽지 편집모드
typedef enum {
    
    NormalMode = 0, // 일반
    ModifyMode = 1  // 편집
    
} ModifyStatus;

#pragma 전문가 상담 버튼 상태
typedef enum {
    ProfessionalNormalMode = 0, // 일반
    ProfessionalModifyMode = 1 // 편집
    
} ProfessionalButtonStatus;

#endif /* EnumType_h */
