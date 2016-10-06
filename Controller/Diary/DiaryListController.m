//
//  DiaryListController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListController.h"

@interface DiaryListController ()

@end

@implementation DiaryListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /** tableView Setting **/
    _diaryListTableController = [[DiaryListModel alloc]init];
    _diaryListTableController.delegate = self;
    
    [_listTableview setDelegate:_diaryListTableController];
    [_listTableview setDataSource:_diaryListTableController];
    _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTableview reloadData];
    
    _searchPage = [[NSNumber alloc] initWithInt:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *) indexPath{
    [_delegate tableView:tableView selectedIndexPath:indexPath];
}

- (void)setListFirst:(NSDate *)date{
    [self showIndicator];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"YYYYMM"];
    [param setValue:[formatter2 stringFromDate:date] forKey:@"search_month"];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:_searchPage forKey:@"searchPage"];
    
    [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        NSLog(@"data : %@", data);
        if([code isEqualToString:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            [_diaryListTableController.diaryList removeAllObjects];
            [_diaryListTableController.diaryList addObjectsFromArray:result];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_listTableview reloadData];
                [self hideIndicator];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideIndicator];
            });
        }
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideIndicator];
        });
        
    }];
}

- (void)setListMore:(NSDate *)date{
    
}

@end
