//
//  MoreProfessionalAdviceViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalAdviceViewController.h"

@interface MoreProfessionalAdviceViewController ()



@end

@implementation MoreProfessionalAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adviceAction:(id)sender {
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGRect frame = _btnExecersize.frame;
        frame.origin.y = frame.origin.y - 100;
        _btnExecersize.frame = frame;
        _btnAdvice.transform = CGAffineTransformRotate(_btnAdvice.transform, M_PI_2 / 2);
        
    } completion:^(BOOL finished){}];
}

- (IBAction)execersizeAction:(id)sender {
    
    
}

- (IBAction)nutritionAction:(id)sender {
    
    
}

- (IBAction)professionalListAction:(id)sender {
    
    [self performSegueWithIdentifier:@"goProfessionalList" sender:nil];
}

@end