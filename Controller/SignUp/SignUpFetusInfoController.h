//
//  SignUpFetusInfoController.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpFetusInfoModel.h"

@interface SignUpFetusInfoController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *fetusInfoTableView;

@property (strong, nonatomic) SignUpFetusInfoModel *fetusInfoTableDelegate;

@end
