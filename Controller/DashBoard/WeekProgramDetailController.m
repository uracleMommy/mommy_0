//
//  WeekProgramDetailController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 24..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeekProgramDetailController.h"

@interface WeekProgramDetailController ()

@end

@implementation WeekProgramDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = _htmlUrl;
    NSURL *url = [[NSURL alloc] initWithString:path];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
