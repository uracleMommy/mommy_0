//
//  CommunityNewspeedImageCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityNewspeedImageCustomCell.h"
#import "CommunitySliderImageCell.h"
#import "MainSliderCell.h"

@implementation CommunityNewspeedImageCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _cachedImages = [[NSMutableDictionary alloc] init];
//    _imageSlider.userPage = self;
//    _imageSlider.dataSource = self;
//    _imageSlider.delegate = self;
    
    [_cellView.layer setBorderColor:[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0].CGColor];
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
    NSString *like;
    if([[self likeButtonImage].image isEqual:[UIImage imageNamed:@"contents_comm_icon_like"]]){
        like = @"Y";
    }else{
        like = @"N";
    }
    
    [_delegate likeButtonAction:self like:like type:@"IMAGE"];
}

- (IBAction)moveDetailViewButtonAction:(id)sender {
    [_delegate moveDetailViewButtonAction:_data];
}

- (IBAction)moveWriteMessageViewAction:(id)sender {
    [_delegate moveWriteMessageViewAction:self];
}

- (IBAction)showProfilePopupViewAction:(id)sender {
    [_delegate showProfilePopupViewAction:self];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CommunitySliderImageCell";
    
    UINib *reuseImageSliderCell = [UINib nibWithNibName:@"CommunitySliderImageCell" bundle:nil];
    [collectionView registerNib:reuseImageSliderCell forCellWithReuseIdentifier:cellIdentifier];
    
    CommunitySliderImageCell *cell =  (CommunitySliderImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [[_imageArr objectAtIndex:indexPath.row] objectForKey:@"file_name"]];
    
    if ([_cachedImages objectForKey:profileImageIdentifier] != nil) {
        [cell.imageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
    }else {
        char const * s = [profileImageIdentifier  UTF8String];
        dispatch_queue_t queue = dispatch_queue_create(s, 0);
        dispatch_async(queue, ^{
            
            NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@&s=%d", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [[_imageArr objectAtIndex:indexPath.row] objectForKey:@"atch_file_key"], (int)indexPath.row];
            
            UIImage *profileImg = nil;
            NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
            profileImg = [[UIImage alloc] initWithData:firstImageData];
            
            [_cachedImages setValue:profileImg forKey:profileImageIdentifier];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.imageView setImage:[_cachedImages valueForKey:profileImageIdentifier]];
            });
        });
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_imageArr count];
}

- (void)pagerDidSelectedPage:(NSInteger)selectedPage {
    
    NSLog(@"PSH selectedPage : %li", (long)selectedPage);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"PSH collectionView didSelecte : %li", (long)indexPath.row);
    
    [_delegate collectionView:self.cachedImages didSelectItemAtIndexPath:indexPath selectedCell:self];
}


@end
