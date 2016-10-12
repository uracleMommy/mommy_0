//
//  MoreProfessionalAdviceReplyViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 11..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface MoreProfessionalAdviceReplyViewController : CommonViewController

@property (strong, nonatomic) NSDictionary *replyInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblProfessionalName;

@property (weak, nonatomic) IBOutlet UILabel *lblReplyDate;

@property (weak, nonatomic) IBOutlet UITextView *txtReplyContent;

@end
