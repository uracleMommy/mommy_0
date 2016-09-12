//
//  termsPopupViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol termsPopupViewDelegate <NSObject>

- (void)okButtonAction;

@end
@interface termsPopupViewController : UIViewController

@property (weak, nonatomic) id<termsPopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *button_0;
@property (weak, nonatomic) IBOutlet UIButton *button_1;
@property (weak, nonatomic) IBOutlet UIButton *button_2;

- (IBAction)okButtonAction:(id)sender;
- (IBAction)cancleButtonAction:(id)sender;

@end
