//
//  MoreMyPageFetusHeaderCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "IQDropDownTextField.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQUITextFieldView+Additions.h"

@protocol MoreMyPageFetusHeaderCellDelegate <NSObject>

@optional

-(void)changeCell:(NSInteger)count;

@end

@interface MoreMyPageFetusHeaderCell : UITableViewCell <IQDropDownTextFieldDelegate>

@property (weak, nonatomic) IBOutlet IQDropDownTextField *txtFetusCount;
@property (strong, nonatomic) id<MoreMyPageFetusHeaderCellDelegate> delegate;

@end
