//
//  MoreBloodPressureInfoView.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureInfoView.h"

@interface MoreBloodPressureInfoView ()

@property (weak, nonatomic) IBOutlet UIView *testView;

- (IBAction)pushBtn:(id)sender;

@end

@implementation MoreBloodPressureInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 스와이프 제스쳐 추가
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(testtest)];
    
    UITapGestureRecognizer *aaa = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testtest)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nilSymbol)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [_testView addGestureRecognizer:swipeLeft];
    
}

- (void) testtest {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushBtn:(id)sender {
}
@end
