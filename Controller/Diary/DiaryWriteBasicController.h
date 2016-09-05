//
//  DiaryWriteBasicController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 17..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDownTextField.h"

@interface DiaryWriteBasicController : UIViewController <UITextViewDelegate, IQDropDownTextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton01;
@property (weak, nonatomic) IBOutlet UIButton *imageButton02;
@property (weak, nonatomic) IBOutlet UIButton *imageButton03;
@property (weak, nonatomic) IBOutlet UIButton *imageButton04;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end