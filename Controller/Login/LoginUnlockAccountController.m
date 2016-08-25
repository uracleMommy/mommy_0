//
//  LoginUnlockAccountController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginUnlockAccountController.h"

@interface LoginUnlockAccountController ()

@end

@implementation LoginUnlockAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    t_count = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getConfirmNumberAction:(id)sender {
    if(![confirmNumberTimer isValid]){
        t_count = 0;
        confirmNumberTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTimer:) userInfo:nil repeats:YES];
    }
}

- (void)countTimer:(NSTimer *)timer{
    t_count++;
    
    int timerText = 180-t_count;
    _timerLabel.text = [NSString stringWithFormat:@"%02d : %02d", timerText/60, timerText%60];
    
    if(t_count == 180){
        [confirmNumberTimer invalidate];
    }
    
}
@end
