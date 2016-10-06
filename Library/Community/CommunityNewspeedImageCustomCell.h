//
//  CommunityNewspeedImageCustomCell.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWViewPager.h"

@protocol CommunityNewspeedImageCustomCellDelegate <NSObject>

@optional
- (void)moreButtonAction:(id)sender point:(CGPoint)point;
- (void)likeButtonAction:(id)sender;
- (void)moveDetailViewButtonAction:(id)sender;
- (void)moveWriteMessageViewAction:(id)sender;
- (void)showProfilePopupViewAction:(id)sender;

@end


@interface CommunityNewspeedImageCustomCell : UITableViewCell <HWViewPagerDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet HWViewPager *imageSlider;
@property (strong, nonatomic) id<CommunityNewspeedImageCustomCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *writerInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *likeButtonImage;

- (IBAction)moreButtonAction:(id)sender;
- (IBAction)likeButtonAction:(id)sender;
- (IBAction)moveDetailViewButtonAction:(id)sender;
- (IBAction)moveWriteMessageViewAction:(id)sender;
- (IBAction)showProfilePopupViewAction:(id)sender;


@end
