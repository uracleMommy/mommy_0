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
#import "SignUpRecommedWeightController.h"

@interface SignUpFetusInfoController : CommonViewController <fetusInfoModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fetusInfoTableView;
@property (strong, nonatomic) SignUpFetusInfoModel *fetusInfoTableDelegate;
@property (strong, nonatomic) NSString *file_name;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSNumber *address;
@property (strong, nonatomic) NSString *baby_birth;
@property (strong, nonatomic) NSString *before_weight;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *baby_cnt;
@property (strong, nonatomic) NSDictionary *recommendParam;

- (IBAction)saveButtonAction:(id)sender;

@end
