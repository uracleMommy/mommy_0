//
//  ExerciseCountDownController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ExerciseCountDownController.h"

@interface ExerciseCountDownController ()

@end

@implementation ExerciseCountDownController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    
//    _lblSecond.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    _startSecond = 5;
    _lblSecond.text = [NSString stringWithFormat:@"%ld", (long)_startSecond];
    
    
    _stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void) updateTimer {
    
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        _lblSecond.transform = CGAffineTransformMakeScale(1.3,1.3);
//    }];
    
    _startSecond--;
    _lblSecond.text = [NSString stringWithFormat:@"%ld", (long)_startSecond];
    
    _lblSecond.transform = CGAffineTransformMakeScale(0.5,0.5);
    
    [UIView animateWithDuration:1.0 animations:^{
        _lblSecond.transform = CGAffineTransformMakeScale(1.0,1.0);
    } completion:^(BOOL finished){
        
//        _lblSecond.transform = CGAffineTransformMakeScale(0.5,0.5);
    }];
    
    if (_startSecond  == -1) {
        
        [_stopTimer invalidate];
        _stopTimer = nil;
        
        // 다음뷰로 이동
        [self.view removeFromSuperview];
        
        UIStoryboard *dashBoardStoryboard = [UIStoryboard storyboardWithName:@"DashBoard" bundle:nil];
        UIViewController *exerciseTimerController = [dashBoardStoryboard instantiateViewControllerWithIdentifier:@"ExerciseCountTimer"];
        
        
        CGRect size = [[UIScreen mainScreen] bounds];
        [exerciseTimerController.view setFrame:size];
        
        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.window addSubview:exerciseTimerController.view];
        
    }
    
    NSLog(@"1초마다 호출");
    
//    NSDate *currentDate = [NSDate date];
//    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
//    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
//    NSString *timeString=[dateFormatter stringFromDate:timerDate];
//    _lbl_timer.text = timeString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end