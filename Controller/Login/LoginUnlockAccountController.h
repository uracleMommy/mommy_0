//
//  LoginUnlockAccountController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "notPasteField.h"

@interface LoginUnlockAccountController : CommonViewController {
    int t_count;
    NSTimer *confirmNumberTimer;
}

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet notPasteField *phoneNumberTextField;
@property (strong, nonatomic) NSString *idText;

- (IBAction)getConfirmNumberAction:(id)sender;
- (IBAction)confirmButtonAction:(id)sender;

@end
