//
//  CommunityProfilePopupViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommunityProfilePopupViewDelegate <NSObject>

@optional
- (void)moveWriteMessageViewAction:(id)sender;
- (void)moveNewspeedViewAction:(id)sender;

@end

@interface CommunityProfilePopupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *todayTitleLabel;
@property (strong, nonatomic) id<CommunityProfilePopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *mentorButton;

- (IBAction)closePopupAction:(id)sender;
- (IBAction)moveWriteMessageViewAction:(id)sender;
- (IBAction)moveNewspeedViewAction:(id)sender;
- (IBAction)toggleMentorAction:(id)sender;

@end
