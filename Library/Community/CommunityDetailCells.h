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
- (void)showProfilePopupViewAction:(id)sender;

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
@property (weak, nonatomic) IBOutlet UIButton *writerPersonImage;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *writerNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *regDateLabel;

- (IBAction)moreButtonAction:(id)sender;
- (IBAction)showProfilePopupViewAction:(id)sender;

@end
