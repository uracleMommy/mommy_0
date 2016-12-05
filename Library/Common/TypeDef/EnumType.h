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

#pragma 커뮤니티 모드
typedef enum {
    
    GroupMode = 0, // 그룹
    MentorMode = 1  // 멘토
    
} ViewMode;

#pragma 전문가 상담 버튼 터치
typedef enum {

    ProfessionalButtonExecersize,
    ProfessionalButtonNutrition
} ProfessionalButtonKind;

#pragma 전문가 상담 글쓰기모드
typedef enum {
    
    ProfessionalQuestionWriteMode,
    ProfessionalQuestionUpdateMode
} ProfessionalQuestionWriteUpdateMode;

#pragma 디바이스 종류
typedef enum {
    
    SearchDeviceBand, // 밴드
    SearchDeviceWeight // 체중계
} SearchDeviceKind;

#pragma 체중계 차트 종류
typedef enum {
    
    WeightChartDaily,
    WeightChartWeekly
} WeigthChartKind;

#pragma 금주의 프로그램 활성화된 화면 종류
typedef enum {
    
    WeekProgramEnabledHealth,
    WeekProgramEnabledSport,
    WeekProgramEnabledNutrition
} WeekProgramEnabledKind;

#pragma 이용약관
typedef enum {
    
    AuthText1 = 1,
    AuthText2 = 2,
    AuthText3 = 3
} AuthTextType;

#endif /* EnumType_h */
