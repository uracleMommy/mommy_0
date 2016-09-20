//
//  MoreProfessionalInfoViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalInfoViewController.h"

@interface MoreProfessionalInfoViewController ()


@end

@implementation MoreProfessionalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[@"홍길동", @"김나래", @"김정신"];
    _segmentView.items = items;
    
    _segmentView.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
//    _segmentView.delegate = self;
    _segmentView.selectedSegmentIndex = 0;
    
    [_segmentView setShowsCount:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
