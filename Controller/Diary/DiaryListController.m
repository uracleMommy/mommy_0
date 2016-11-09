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
    _currentLastPageStatus = NO;
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
    _selectedDate = date;
    _searchPage = [[NSNumber alloc]initWithInt:1];
//    [self showIndicator];
    
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
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if(!_noDataController){
                        _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataDiaryController"];
                        [_noDataController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                        [self.view addSubview : _noDataController.view];
                        _noDataController.view.hidden = NO;
                    }else{
                        _noDataController.view.hidden = NO;
                    }
                    _listTableview.hidden = YES;
                });
            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    //만일 데이터 없음으로 되어 있을 시에는 다시 생기도록 해주기
                    _listTableview.hidden = NO;
                    if(_noDataController){
                        _noDataController.view.hidden = YES;
                    }
                });
                [_diaryListTableController.diaryList removeAllObjects];
                [_diaryListTableController.diaryList addObjectsFromArray:result];
                
                if([result count] == 0 || [[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                    _currentLastPageStatus = YES;
                }else{
                    _currentLastPageStatus = NO;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_listTableview reloadData];
                    //                [self hideIndicator];
                });
            }
        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self hideIndicator];
//            });
        }
    } error:^(NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self hideIndicator];
//        });
        
    }];
}

#pragma 테이블뷰 맨마지막 셀 도달시 추가 로드
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count {
    if (!_currentLastPageStatus) {
        return;
    }
    
    [self setListMore:_selectedDate searchPage:[[NSNumber alloc] initWithInt:([_searchPage intValue]+[PAGE_SIZE intValue]) ]];
}


- (void)setListMore:(NSDate *)date searchPage:(NSNumber *)searchPage{
    
    _selectedDate = date;
    //    [self showIndicator];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"YYYYMM"];
    [param setValue:[formatter2 stringFromDate:date] forKey:@"search_month"];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:searchPage forKey:@"searchPage"];
    
    [[MommyRequest sharedInstance] mommyDiaryApiService:DiaryList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        NSLog(@"data : %@", data);
        if([code isEqualToString:@"0"]){
            _searchPage = searchPage;
            
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            
            [_diaryListTableController.diaryList addObjectsFromArray:result];
            
            
            if([result count] == 0 || ([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue]) >= ([_searchPage intValue]+[PAGE_SIZE intValue])){
                _currentLastPageStatus = YES;
            }else{
                _currentLastPageStatus = NO;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_listTableview reloadData];
                //                [self hideIndicator];
            });
        }else{
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [self hideIndicator];
            //            });
        }
    } error:^(NSError *error) {
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            [self hideIndicator];
        //        });
        
    }];
}

@end
