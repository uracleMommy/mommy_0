//
//  QuestionViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "QuestionScrollViewController.h"

@interface QuestionViewController : CommonViewController

@property (strong, nonatomic) NSNumber *momWeek; // 임신주차

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (strong, nonatomic) QuestionScrollViewController *questionScrollViewController;

@property (weak, nonatomic) IBOutlet UIView *scrollContainerView;

- (IBAction)submitResult:(id)sender;

@end
