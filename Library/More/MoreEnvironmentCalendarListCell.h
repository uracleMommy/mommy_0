//
//  MoreEnvironmentCalendarListCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreEnvironmentCalendarListCellDelegate <NSObject>

@required
-(void)googleAuthLinkAction;

@end

@interface MoreEnvironmentCalendarListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *calendarImageView;

@property (weak, nonatomic) IBOutlet UILabel *lblCalendarInfo;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UIButton *authButton;

@property (strong, nonatomic) id<MoreEnvironmentCalendarListCellDelegate> delegate;

- (IBAction)googleAuthLinkAction:(id)sender;

@end
