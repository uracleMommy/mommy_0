//
//  LoginUnlockAccountController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginUnlockAccountController : UIViewController{
    int t_count;
    NSTimer *confirmNumberTimer;
}

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)getConfirmNumberAction:(id)sender;

@end
