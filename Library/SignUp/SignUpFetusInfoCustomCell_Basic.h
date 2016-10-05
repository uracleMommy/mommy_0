//
//  SignUpFetusInfoCustomCell_Basic.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notPasteField.h"

@protocol fetusInfoBasicCellDelegate <NSObject>

@required
- (void)deleteTableCell:(id)sender;

@end

@interface SignUpFetusInfoCustomCell_Basic : UITableViewCell

@property (weak, nonatomic) id<fetusInfoBasicCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet notPasteField *fetusNameTextField;

- (IBAction)deleteInputContents:(id)sender;

@end
