//
//  emoticonPopupViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol emoticonPopupViewDelegate <NSObject>

- (void)clickButton:(int)tag;

@end

@interface emoticonPopupViewController : UIViewController

@property (weak, nonatomic) id<emoticonPopupViewDelegate> delegate;

- (IBAction)closePopup:(id)sender;
- (IBAction)clickButton:(id)sender;

@end
