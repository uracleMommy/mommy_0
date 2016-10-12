//
//  MoreProfessionalAdviceReplyViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 11..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalAdviceReplyViewController.h"
#import "MommyUtils.h"

@interface MoreProfessionalAdviceReplyViewController ()

@end

@implementation MoreProfessionalAdviceReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    NSString *professionalName = _replyInfo[@"detail"][@"professor_name"] == [NSNull null] ? @"" : _replyInfo[@"detail"][@"professor_name"];
    NSString *professionalReplyContent = _replyInfo[@"detail"][@"professor_content"] == [NSNull null] ? @"" : _replyInfo[@"detail"][@"professor_content"];
    NSString *replyDate = _replyInfo[@"detail"][@"reply_reg_dttm"] == [NSNull null] ? @"" :_replyInfo[@"detail"][@"reply_reg_dttm"];
    
    _lblProfessionalName.text = professionalName;
    _txtReplyContent.text = professionalReplyContent;
    _lblReplyDate.text = [[MommyUtils sharedGlobalData] getMommyDateyyyyMMdd:replyDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
