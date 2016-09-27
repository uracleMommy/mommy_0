//
//  QuestionScrollViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionScrollViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UITextView *txtView;

@property (weak, nonatomic) IBOutlet UIImageView *imageFirstQuestion1;

@property (weak, nonatomic) IBOutlet UIImageView *imageFirstQuestion2;

@property (weak, nonatomic) IBOutlet UIImageView *imageFirstQuestion3;

- (IBAction)firstButtonSelect:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageSecondQuestion1;

@property (weak, nonatomic) IBOutlet UIImageView *imageSecondQuestion2;

@property (weak, nonatomic) IBOutlet UIImageView *imageSecondQuestion3;

- (IBAction)secondButtonSelect:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageThirdQuestion1;

@property (weak, nonatomic) IBOutlet UIImageView *imageThirdQuestion2;

@property (weak, nonatomic) IBOutlet UIImageView *imageThirdQuestion3;

- (IBAction)thirdButtonSelect:(id)sender;

@end
