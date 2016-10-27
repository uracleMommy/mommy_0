//
//  CommunityNewspeedImageCustomCell.h
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWViewPager.h"
#import "MommyRequest.h"

@protocol CommunityNewspeedImageCustomCellDelegate <NSObject>

@optional
- (void)moreButtonAction:(id)sender point:(CGPoint)point;
- (void)likeButtonAction:(id)sender like:(NSString *)like type:(NSString *)type;
- (void)moveDetailViewButtonAction:(NSDictionary *)data;
- (void)moveWriteMessageViewAction:(id)sender;
- (void)showProfilePopupViewAction:(id)sender;
- (void)collectionView:(NSDictionary *)imageArr didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedCell:(id)sender;

@end


@interface CommunityNewspeedImageCustomCell : UITableViewCell <HWViewPagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet HWViewPager *imageSlider;
@property (strong, nonatomic) id<CommunityNewspeedImageCustomCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *writerInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *likeButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *mentoImageButton;
@property (weak, nonatomic) IBOutlet UILabel *mentoNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *regDttmLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) NSArray *imageArr;
@property (strong, nonatomic) NSMutableDictionary *cachedImages;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentsHeightConstraint;
@property (strong, nonatomic) NSDictionary *data;

- (IBAction)moreButtonAction:(id)sender;
- (IBAction)likeButtonAction:(id)sender;
- (IBAction)moveDetailViewButtonAction:(id)sender;
- (IBAction)moveWriteMessageViewAction:(id)sender;
- (IBAction)showProfilePopupViewAction:(id)sender;


@end
