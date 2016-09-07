//
//  ExerciseTimerController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseTimerController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTimer;

@property (weak, nonatomic) IBOutlet UILabel *lblBpm;

- (IBAction)playAction:(id)sender;

- (IBAction)puaseAction:(id)sender;

- (IBAction)stopAction:(id)sender;

- (IBAction)stopTimer:(id)sender;

@property (strong, nonatomic) NSTimer *stopTimer;

@property (strong, nonatomic) NSDate *startDate;

@end