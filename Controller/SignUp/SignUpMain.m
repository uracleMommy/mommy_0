//
//  SignUpMain.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMain.h"

@interface SignUpMain ()

@end

@implementation SignUpMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMainScrollView"];

    [scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 664)];
    
    [_scrollView addSubview : scrollViewContoller.view];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 664);
}

/*
#pragma mark - Navigationf

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
