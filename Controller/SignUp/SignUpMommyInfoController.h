//
//  SignUpMommyInfoController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "IQKeyboardManager.h"

@interface SignUpMommyInfoController : UIViewController{
    
    UIViewController *scrollViewContoller;
}
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@end
