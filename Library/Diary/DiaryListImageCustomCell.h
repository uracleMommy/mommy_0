//
//  DiaryListImageCustomCell.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryListImageCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UILabel *regDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isvalidImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emoticonImageView;
@property (weak, nonatomic) IBOutlet UILabel *emoticonLabel;
@property (weak, readwrite, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) NSString *diaryKey;

@end
