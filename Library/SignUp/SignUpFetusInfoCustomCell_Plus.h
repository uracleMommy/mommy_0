//
//  SignUpFetusInfoCustomCell_Plus.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fetusInfoPlusCellDelegate <NSObject>

- (void)addTableCell;

@end

@interface SignUpFetusInfoCustomCell_Plus : UITableViewCell

- (IBAction)addFetusCell:(id)sender;

@property (weak, nonatomic) id<fetusInfoPlusCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *maxCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@end
