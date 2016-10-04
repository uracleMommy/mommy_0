//
//  SignUpFetusInfoController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpFetusInfoModel.h"
#import "CommonViewController.h"

@interface SignUpFetusInfoController : CommonViewController <fetusInfoModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fetusInfoTableView;
@property (strong, nonatomic) SignUpFetusInfoModel *fetusInfoTableDelegate;

- (IBAction)saveButtonAction:(id)sender;

@end
