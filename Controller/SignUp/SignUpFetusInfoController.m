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
    
    
    [self.navigationItem setHidesBackButton:YES];
    
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
//        UITextField *selectedTextField = (UITextField*)sender;
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
- (IBAction)saveButtonAction:(id)sender {
    NSArray *tableTextFieldArr = [self findAllTextFieldsInView:_fetusInfoTableView];
    NSMutableArray *fetusInfoArr = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < [tableTextFieldArr count] ; i++){
        NSString *text = [(UITextField *)[tableTextFieldArr objectAtIndex:i] text];
        if(![text isEqualToString:@""]){
            [fetusInfoArr addObject:text];
        }
    }
    
    
    if([sender tag] == 1 && [fetusInfoArr count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"태명을 입력해주시기 바랍니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    [self showIndicator];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    if([sender tag] == 0){
        [param setValue:@"" forKey:@"baby_names"];
    }else{
        [param setValue:[fetusInfoArr componentsJoinedByString:@"|"] forKey:@"baby_names"];
    }
    
    NSMutableDictionary *images = [[NSMutableDictionary alloc] init];
    [images setValue:_file_name forKey:@"file_name"];
    
    [param setValue:@[images] forKey:@"images"];
    [param setValue:_nickname forKey:@"nickname"];
    [param setValue:_address forKey:@"address"];
    [param setValue:_baby_birth forKey:@"baby_birth"];
    [param setValue:_before_weight forKey:@"before_weight"];
    [param setValue:_weight forKey:@"weight"];
    [param setValue:_height forKey:@"height"];
    [param setValue:_baby_cnt forKey:@"baby_cnt"];
    
    NSLog(@"param : %@", param);
    
    [[MommyRequest sharedInstance] mommySignInApiService:InsertUserProfile authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard *mainTabBarStoryboard = [UIStoryboard storyboardWithName:@"MainTabBar" bundle:nil];
                UINavigationController *mainTabBarNavigationController = (UINavigationController *)[mainTabBarStoryboard instantiateViewControllerWithIdentifier:@"MainTabBarNavigation"];
                
                [self presentViewController:mainTabBarNavigationController animated:YES completion:nil];
            });
        }else{
            //TODO 등록 실패시..
        }
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}

@end
