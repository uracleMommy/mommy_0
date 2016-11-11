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

@property (weak, nonatomic) IBOutlet UITextView *authTextField;
@property (assign, nonatomic) AuthTextType *type;

@end
