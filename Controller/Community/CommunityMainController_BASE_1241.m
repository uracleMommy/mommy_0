//
//  CommunityMainController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityMainController.h"

@interface CommunityMainController ()

@end

@implementation CommunityMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //navigation setting
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = @"커뮤니티";
    
    
    //tab setting
    NSArray *items = @[@"MY", @"멘토"];
    _tabView.items = items;
    _tabView.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _tabView.delegate = self;
    _tabView.selectedSegmentIndex = 0;
    [_tabView setShowsCount:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
-(void)viewDidAppear:(BOOL)animated{
    if(!_myGroupViewController){
        _myGroupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CommunityMyGroupView"];
        
        //        _contentViewController.delegate = self;
//        _myGroupViewController.delegate = self;
        [_myGroupViewController.view setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        
        [_contentView addSubview : _myGroupViewController.view];
        
        //        [_scrollView sizeToFit];
    }
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
