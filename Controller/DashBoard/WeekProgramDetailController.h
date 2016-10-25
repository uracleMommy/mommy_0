//
//  WeekProgramDetailController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 24..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekProgramDetailController : UIViewController

@property (strong, nonatomic) NSString *htmlUrl;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
