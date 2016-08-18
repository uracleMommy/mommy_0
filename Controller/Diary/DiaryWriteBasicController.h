//
//  DiaryWriteBasicController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 17..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryWriteBasicController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;

@property (strong, nonatomic) UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UIButton *imageButton01;
@property (weak, nonatomic) IBOutlet UIButton *imageButton02;
@property (weak, nonatomic) IBOutlet UIButton *imageButton03;
@property (weak, nonatomic) IBOutlet UIButton *imageButton04;

@end
