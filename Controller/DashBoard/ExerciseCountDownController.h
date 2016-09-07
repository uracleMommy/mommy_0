//
//  ExerciseCountDownController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@protocol ExerciseCountDownControllerDelegate;

@interface ExerciseCountDownController : CommonViewController

@property (weak, nonatomic) IBOutlet UILabel *lblSecond;

@property (strong, nonatomic) NSTimer *stopTimer;

@property (assign) NSInteger startSecond;

@end

@protocol ExerciseCountDownControllerDelegate <NSObject>

@required

- (void) completedCount;

@end