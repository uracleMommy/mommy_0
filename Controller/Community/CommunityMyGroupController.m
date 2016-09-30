//
//  CommunityMyGroupController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityMyGroupController.h"

@interface CommunityMyGroupController ()

@end

@implementation CommunityMyGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)moveCommunityList:(id)sender {
    [_delegate moveCommunityList];
}
@end
