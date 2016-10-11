//
//  MoreProfessionalButtonViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumType.h"

@protocol MoreProfessionalButtonViewControllerDelegate;

@interface MoreProfessionalButtonViewController : UIViewController

@property (assign) ProfessionalButtonStatus professionalButtonStatus;

@property (weak, nonatomic) IBOutlet UIView *containerExecersizeView;

@property (weak, nonatomic) IBOutlet UIView *containerNutritionView;

@property (weak, nonatomic) IBOutlet UIButton *btnAdvice;

@property (weak, nonatomic) IBOutlet UILabel *lblExecersize;

@property (weak, nonatomic) IBOutlet UILabel *lblNutrition;

@property (strong, nonatomic) id<MoreProfessionalButtonViewControllerDelegate> delegate;

- (IBAction)adviceAction:(id)sender;

- (IBAction)execersizeAction:(id)sender;

- (IBAction)nutritionAction:(id)sender;

@end

@protocol MoreProfessionalButtonViewControllerDelegate <NSObject>

@optional

- (void) professionalButtonStatus : (ProfessionalButtonStatus) professionalButtonStatus;

- (void) professionalButtonTouch : (ProfessionalButtonKind) professionalButtonKind;

@end
