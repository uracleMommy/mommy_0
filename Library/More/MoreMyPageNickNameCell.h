//
//  MoreMyPageNickNameCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreMyPageNickNameCellDelegate <NSObject>

@optional

- (void) NickNameTouch;

@end

@interface MoreMyPageNickNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblNickName;

@property (strong, nonatomic) id<MoreMyPageNickNameCellDelegate> delegate;

@end
