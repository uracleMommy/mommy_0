//
//  CommonViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommonViewController.h"

@implementation CommonViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

#pragma mark 인디케이터 관련

//AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//[appDelegate indicatorViewIn];

- (void) showIndicator {
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate indicatorViewIn];
}

- (void) hideIndicator {
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate indicatorViewOut];
}

@end