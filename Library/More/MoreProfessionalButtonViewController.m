//
//  MoreProfessionalButtonViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalButtonViewController.h"

@interface MoreProfessionalButtonViewController ()

@end

@implementation MoreProfessionalButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 버튼 액션 관련

#pragma 상담
- (IBAction)adviceAction:(id)sender {
    
//    if ([self.delegate respondsToSelector:@selector(professionalButtonStatus:)]) {
//        
//        [self.delegate professionalButtonStatus:_professionalButtonStatus];
//        
//    }
    
    
    if (_professionalButtonStatus == ProfessionalNormalMode) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
            [self.view needsUpdateConstraints];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    CGRect execersizeViewframe = _containerExecersizeView.frame;
                    execersizeViewframe.origin.y = execersizeViewframe.origin.y - 120;
                    _containerExecersizeView.frame = execersizeViewframe;
                    _lblExecersize.hidden = NO;
                    
                    CGRect nutritionViewframe = _containerNutritionView.frame;
                    nutritionViewframe.origin.y = nutritionViewframe.origin.y - 60;
                    _containerNutritionView.frame = nutritionViewframe;
                    _lblNutrition.hidden = NO;
                    
                    _btnAdvice.transform = CGAffineTransformRotate(_btnAdvice.transform, M_PI_2 / 2);
                    
                    self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.7f];
                    
                    
                } completion:^(BOOL finished){
                    
                    _professionalButtonStatus = ProfessionalModifyMode;
                }];
            });
        });
    }
    
    else {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            CGRect execersizeViewframe = _containerExecersizeView.frame;
            execersizeViewframe.origin.y = execersizeViewframe.origin.y + 60;
            _containerExecersizeView.frame = execersizeViewframe;
            _lblExecersize.hidden = YES;
            
            
            CGRect nutritionViewframe = _containerNutritionView.frame;
            nutritionViewframe.origin.y = nutritionViewframe.origin.y + 120;
            _containerNutritionView.frame = nutritionViewframe;
            _lblNutrition.hidden = YES;
            
            _btnAdvice.transform = CGAffineTransformRotate(_btnAdvice.transform, M_PI_2 / 2);
            
            self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.0f];
            
        } completion:^(BOOL finished){
            
            self.view.frame = CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 85, [[UIScreen mainScreen] applicationFrame].size.height - 65, 85, 85);
            [self.view needsUpdateConstraints];
            _professionalButtonStatus = ProfessionalNormalMode;
        }];
    }
}

#pragma 운동
- (IBAction)execersizeAction:(id)sender {
    
    [self adviceAction:nil];
    
    if ([self.delegate respondsToSelector:@selector(professionalButtonTouch:)]) {
        [self.delegate professionalButtonTouch:ProfessionalButtonExecersize];
    }
}

#pragma 영양
- (IBAction)nutritionAction:(id)sender {
    
    [self adviceAction:nil];
    
    if ([self.delegate respondsToSelector:@selector(professionalButtonTouch:)]) {
        [self.delegate professionalButtonTouch:ProfessionalButtonNutrition];
    }
}

@end
