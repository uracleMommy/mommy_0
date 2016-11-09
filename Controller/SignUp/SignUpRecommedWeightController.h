//
//  SignUpRecommedWeightController.h
//  co.medisolution
//
//  Created by uracle on 2016. 11. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface SignUpRecommedWeightController : CommonViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *functionJson;
@property (assign, nonatomic) Boolean isFirst;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) NSDictionary *param;

- (IBAction)moveDashBoard:(id)sender;

@end
