//
//  WeekProgramSearchViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 24..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "WeekProgramModel.h"

@interface WeekProgramSearchViewController : CommonViewController<WeekProgramModelDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchView;

@property (strong, nonatomic) NSString *searchText;

@property (assign, nonatomic) WeekProgramEnabledKind weekProgramEnabledKind;

@property (strong, nonatomic) WeekProgramModel *weekProgramModel;

@property (strong, nonatomic) NSString *weightStatusCode;

@end
