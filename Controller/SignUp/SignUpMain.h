//
//  SignUpMain.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpMain : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *idValidationLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidationLabel;

@end

