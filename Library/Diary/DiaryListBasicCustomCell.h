//
//  DiaryListBasicCustomCell.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryListBasicCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) CAShapeLayer *border;

@end
