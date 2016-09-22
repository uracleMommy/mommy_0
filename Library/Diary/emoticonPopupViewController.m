//
//  emoticonPopupViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "emoticonPopupViewController.h"

@interface emoticonPopupViewController ()

@end

@implementation emoticonPopupViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _popupView.layer.cornerRadius = 20;//half of the width
    
    _popupView.layer.masksToBounds = YES;
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

- (IBAction)closePopup:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)clickButton:(id)sender {
    [self.view removeFromSuperview];
    [delegate clickButton:(int)[sender tag]];
}

@end

