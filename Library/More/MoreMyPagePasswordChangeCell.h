//
//  MoreMyPagePasswordChangeCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreMyPagePasswordChangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *lblDotLine;

@property (weak, nonatomic) IBOutlet UITextField *lblOriginalPassword;

@property (weak, nonatomic) IBOutlet UITextField *lblNewPassword;

@property (weak, nonatomic) IBOutlet UITextField *lblNewPasswordConfirm;

@end
