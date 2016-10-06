//
//  PushViewListCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushViewListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNoticeTime;

@property (weak, nonatomic) IBOutlet UILabel *lblNoticeContent;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *imgType;

@property (weak, nonatomic) IBOutlet UILabel *lblTypeName;

@end
