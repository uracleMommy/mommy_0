//
//  CommunityDetailCells.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KxMenu.h"

@protocol CommunityDetailCellsDelgate <NSObject>

@optional
- (IBAction)moreButtonAction:(id)sender point:(CGPoint)point;
- (void)showProfilePopupViewAction:(NSString *)personKey personNickname:(NSString *)personNickname;

@end

@interface CommunityDetailCells : UITableViewCell
@property (strong, nonatomic) id<CommunityDetailCellsDelgate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyPersonImage01;
@property (weak, nonatomic) IBOutlet UIImageView *replyPersonImage02;
@property (weak, nonatomic) IBOutlet UIImageView *replyPersonImage03;
@property (weak, nonatomic) IBOutlet UIImageView *replyPersonImage04;
@property (weak, nonatomic) IBOutlet UIImageView *replyPersonImage05;
@property (weak, nonatomic) IBOutlet UIButton *replyPersonButton;
@property (strong, nonatomic) NSString *personKey;
@property (strong, nonatomic) NSString *personNickname;
@property (weak, nonatomic) IBOutlet UIButton *writerPersonImage;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *writerNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *regDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeButton;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *replyContentTextField;
@property (weak, nonatomic) IBOutlet UILabel *replyPersonKickname;
@property (weak, nonatomic) IBOutlet UILabel *replyRegDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentsHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyContentsHeightConstraint;

- (IBAction)moreButtonAction:(id)sender;
- (IBAction)showProfilePopupViewAction:(id)sender;

@end
