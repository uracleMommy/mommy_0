//
//  SignUpMommyInfoController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMommyInfoController.h"

@interface SignUpMommyInfoController ()

@end

@implementation SignUpMommyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMommyInfoScrollView"];
    
    [scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 470)];
    
    [_scrollView addSubview : scrollViewContoller.view];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 470);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
