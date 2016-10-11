//
//  CommunityProfilePopupViewController.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MommyRequest.h"

@protocol CommunityProfilePopupViewDelegate <NSObject>

@optional
- (void)moveWriteMessageViewAction:(id)sender;
- (void)moveNewspeedViewAction:(id)sender;

@end

@interface CommunityProfilePopupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *babyBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalStepLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgStepLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalKalLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgKalLabel;

@property (weak, nonatomic) IBOutlet UILabel *todayTitleLabel;
@property (strong, nonatomic) id<CommunityProfilePopupViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *mentorButton;
@property (strong, nonatomic) NSString *mentorKey;

- (IBAction)closePopupAction:(id)sender;
- (IBAction)moveWriteMessageViewAction:(id)sender;
- (IBAction)moveNewspeedViewAction:(id)sender;
- (IBAction)toggleMentorAction:(id)sender;

@end
