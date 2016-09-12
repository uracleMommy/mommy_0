//
//  MoreMainMenuCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreMainMenuCellDelegate;

@interface MoreMainMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *firstSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *secondSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *thirdSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *fourthSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *fifthSmallContainerView;

@property (weak, nonatomic) IBOutlet UIView *sixthSmallContainerView;

@property (weak, nonatomic) IBOutlet UILabel *firstLblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *secondLblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *thirdLblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *fourthLblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *fifthLblDotLine;

@property (strong, nonatomic) id<MoreMainMenuCellDelegate> delegate;

// 버튼 액션
- (IBAction)goBloodPressure:(id)sender;

// 포인트 액션
- (IBAction)goPoint:(id)sender;

// 주차별 체크리스트 액션
- (IBAction)goWeekCheck:(id)sender;

// 전문가 상담
- (IBAction)goProfessionalAdvice:(id)sender;

// 기기관리
- (IBAction)goEquipmentManagement:(id)sender;

// 환경설정
- (IBAction)goEnvironmentSetup:(id)sender;

@end

@protocol MoreMainMenuCellDelegate <NSObject>

@optional

- (void) moreMenuTouchIndex : (NSInteger) index;

@end