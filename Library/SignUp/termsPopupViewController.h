//
//  termsPopupViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@protocol termsPopupViewDelegate <NSObject>

- (void)okButtonAction;
- (void)cancleButtonAction;
- (void)moveTermsView:(AuthTextType)type;

@end
@interface termsPopupViewController : CommonViewController

@property (weak, nonatomic) id<termsPopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *button_0;
@property (weak, nonatomic) IBOutlet UIButton *button_1;
@property (weak, nonatomic) IBOutlet UIButton *button_2;
@property (assign, nonatomic) AuthTextType type;

- (IBAction)okButtonAction:(id)sender;
- (IBAction)cancleButtonAction:(id)sender;
- (IBAction)termsButtonAction:(id)sender;

@end
