//
//  PushNoticeDetailViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface PushNoticeDetailViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UILabel *lblType;

@property (weak, nonatomic) IBOutlet UILabel *lblWriteTime;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UITextView *txtContent;

@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSString *writeTime;

@property (strong, nonatomic) NSString *pushTitle;

@property (strong, nonatomic) NSString *content;

@end
