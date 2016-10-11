//
//  CommunityNewspeedImageCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityNewspeedImageCustomCell.h"
#import "MainSliderCell.h"

@implementation CommunityNewspeedImageCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _imageSlider.userPage = self;
//    _imageSlider.dataSource = self;
    
    [_cellView.layer setBorderColor:[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f  blue:153.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.cornerRadius = 10;//half of the width
    _cellView.layer.masksToBounds = YES;
    
    _mentoImageButton.layer.cornerRadius = 20;
    _mentoImageButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreButtonAction:(id)sender{
    [_delegate moreButtonAction:self point:CGPointMake(_moreButton.frame.origin.x, self.frame.origin.y + _moreButton.frame.size.height - 10)];
}

- (IBAction)likeButtonAction:(id)sender {
    //    [_delegate likeButtonAction:sender];
    if([_likeButtonImage.image isEqual:[UIImage imageNamed:@"contents_comm_icon_like"]]){
        [_likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like_on"]];
    }else{
        [_likeButtonImage setImage:[UIImage imageNamed:@"contents_comm_icon_like"]];
    }
}

- (IBAction)moveDetailViewButtonAction:(id)sender {
    [_delegate moveDetailViewButtonAction:sender];
}

- (IBAction)moveWriteMessageViewAction:(id)sender {
    [_delegate moveWriteMessageViewAction:sender];
}

- (IBAction)showProfilePopupViewAction:(id)sender {
    [_delegate showProfilePopupViewAction:sender];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MainSliderCell";
    
    
    UINib *reuseMainSliderCell = [UINib nibWithNibName:@"MainSliderCell" bundle:nil];
    [collectionView registerNib:reuseMainSliderCell forCellWithReuseIdentifier:cellIdentifier];
    
    MainSliderCell *cell =  (MainSliderCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}
- (void)pagerDidSelectedPage:(NSInteger)selectedPage {
    
    NSLog(@"PSH selectedPage : %li", (long)selectedPage);
//    DashBoardController *dashBoardController = (DashBoardController *)self.parentViewController;
//    [dashBoardController setMainSliderPage:selectedPage];
    
}



@end
