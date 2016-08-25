//
//  MessageListCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumType.h"

@interface MessageListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblWriteTime;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (assign) ModifyStatus modifyStatus;

@end