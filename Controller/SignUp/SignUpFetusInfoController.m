//
//  SignUpFetusInfoController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpFetusInfoController.h"

@interface SignUpFetusInfoController ()

@end

@implementation SignUpFetusInfoController

- (void)viewDidLoad {
    _fetusInfoTableDelegate = [[SignUpFetusInfoModel alloc]init];
    
    _fetusInfoTableDelegate.delegate = self;
    
    [super viewDidLoad];
    
    [_fetusInfoTableView setDelegate:_fetusInfoTableDelegate];
    [_fetusInfoTableView setDataSource:_fetusInfoTableDelegate];
    
    _fetusInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_fetusInfoTableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableCell{
    NSLog(@"PSH addTableCell");
    [_fetusInfoTableView beginUpdates];
    [[_fetusInfoTableDelegate fetusNames]addObject:@""];
//    NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[_fetusInfoTableDelegate fetusNames].count-1 inSection:1]];
    NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[[_fetusInfoTableDelegate fetusNames] count]-1 inSection:0]];
    [_fetusInfoTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationRight];
//    [_fetusInfoTableView insertRowsAtIndexPaths:[_fetusInfoTableDelegate fetusNames] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_fetusInfoTableView endUpdates];
}

-(void)deleteTableCell:(id)sender{
    NSLog(@"PSH deleteTableCell");
    UITableViewCell *superview = (UITableViewCell *)[[sender superview] superview];
    if(superview != nil){
//        [[_fetusInfoTableDelegate fetusNames] removeObjectAtIndex:0];
        NSIndexPath *indexPath = [_fetusInfoTableView indexPathForCell:superview];
        
        [[_fetusInfoTableDelegate fetusNames] removeObjectAtIndex:indexPath.row];
        
        [_fetusInfoTableView beginUpdates];
        
        [_fetusInfoTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        [_fetusInfoTableView endUpdates];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
