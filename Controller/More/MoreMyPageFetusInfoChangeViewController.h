//
//  MoreMyPageFetusInfoChangeViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreMyPageModel.h"


@interface MoreMyPageFetusInfoChangeViewController : CommonViewController<MoreMyPageFetusContentsCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreMyPageFetusChangeModel *moreMyPageFetusChangeModel;
@property (strong, nonatomic) NSArray *babyNickNames;

- (IBAction)closeModal:(id)sender;

@end
