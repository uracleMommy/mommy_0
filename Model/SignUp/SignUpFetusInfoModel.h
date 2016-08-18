//
//  SignUpFetusInfoModel.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SignUpFetusInfoCustomCell_Basic.h"
#import "SignUpFetusInfoCustomCell_Plus.h"


@protocol fetusInfoModelDelegate <NSObject>

@required
- (void)deleteTableCell:(id)sender;
- (void)addTableCell;

@end


@interface SignUpFetusInfoModel : NSObject <UITableViewDataSource, UITableViewDelegate, fetusInfoBasicCellDelegate, fetusInfoPlusCellDelegate>

@property (nonatomic, strong) NSMutableArray *fetusNames;

@property (weak, nonatomic) id<fetusInfoModelDelegate> delegate;

@end
