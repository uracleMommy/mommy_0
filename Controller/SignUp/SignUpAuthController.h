//
//  SignUpAuthController.h
//  co.medisolution
//
//  Created by uracle on 2016. 11. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface SignUpAuthController : CommonViewController

@property (assign, nonatomic) AuthTextType type;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
