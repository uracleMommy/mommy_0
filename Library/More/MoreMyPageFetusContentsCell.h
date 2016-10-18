//
//  MoreMyPageFetusContentsCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreMyPageFetusContentsCellModel <NSObject>

- (void)deleteBabyNicknameButton:(id)sender;

@end

@interface MoreMyPageFetusContentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *txtFetusName;
@property (strong, nonatomic) id<MoreMyPageFetusContentsCellModel> delegate;

- (IBAction)deleteBabyNicknameButton:(id)sender;

@end
