//
//  MoreProfessionalAdviceCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreProfessionalAdviceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *lblWriteTime;

@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UIButton *replyStatus;

@end
