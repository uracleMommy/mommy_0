//
//  SignUpMain.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpMain : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>{
    UIPickerView *pickerview;
    
    UIViewController *scrollViewContoller;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

