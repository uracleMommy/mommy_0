//
//  MoreMyPagePasswordChangeViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "notPasteField.h"

@interface MoreMyPagePasswordChangeViewController : CommonViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet notPasteField *beforePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidationLabel;
@property (strong, nonatomic) NSMutableArray *passwordValidationArr;

- (IBAction)saveButtonAction:(id)sender;

@end
