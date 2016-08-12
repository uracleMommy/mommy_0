//
//  LoginMain.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginMain : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *idTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwTextField;
@property (strong, nonatomic) IBOutlet UIImageView *autoLoginImage;

-(IBAction)clickAutoLoginButton:(id)sender;

@end
