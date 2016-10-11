//
//  CommunityPersonListCustomCell.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityPersonListCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIImageView *mentorButtonImage;
@property (weak, nonatomic) IBOutlet UILabel *mentorNicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mentorImageView;
@property (weak, nonatomic) IBOutlet UILabel *mentorBirthdayLabel;
@property (strong, nonatomic) NSString *mentorKey;

- (IBAction)toggleMentorAction:(id)sender;

@end
