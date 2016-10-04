//
//  LoginUnlockAccountController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface LoginUnlockAccountController : CommonViewController {
    int t_count;
    NSTimer *confirmNumberTimer;
}

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)getConfirmNumberAction:(id)sender;

@end
