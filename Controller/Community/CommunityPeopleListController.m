//
//  CommunityPeopleListController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityPeopleListController.h"

@interface CommunityPeopleListController ()

@end

@implementation CommunityPeopleListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableListController = [[CommunityPersonListModel alloc] init];
    _tableListController.addMentorButtonFlag = YES;
    _tableListController.delegate = self;
    _tableView.delegate = _tableListController;
    _tableView.dataSource = _tableListController;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _searchPage = [[NSNumber alloc] initWithInt:1];
    _currentLastPageStatus = NO;    
    
    //close Button Setting
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = closeButton;
    self.navigationItem.hidesBackButton = YES;
    
    [self setListFirst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"UnwindingSegue"]){
        CommunityNewspeedListController *vc = [segue destinationViewController];
        [vc setMode:MentorMode];
        [vc setTitleText:_mento_nickname];
        [vc setMentorKey:_mento_id];
    }
}



#pragma mark table delegate
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    if (!_currentLastPageStatus) {
        return;
    }
    
    [self setListMore:[[NSNumber alloc] initWithInt:([_searchPage intValue]+[PAGE_SIZE intValue]) ]];

}

-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
    if (!_profilePopupView) {
        _profilePopupView = [[CommunityProfilePopupViewController alloc] initWithNibName:@"CommunityProfilePopupViewController" bundle:nil];
        _profilePopupView.delegate = self;
        _profilePopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    _profilePopupView.mentorKey = [(CommunityPersonListCustomCell *)[tableView cellForRowAtIndexPath:indexPath] mentorKey];
    _profilePopupView.mentorNickname = [[(CommunityPersonListCustomCell *)[tableView cellForRowAtIndexPath:indexPath] mentorNicknameLabel] text];
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_profilePopupView.view];
}


#pragma mark setting list
- (void)setListFirst{
    _searchPage = [[NSNumber alloc]initWithInt:1];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:_searchPage forKey:@"searchPage"];
    [param setValue:_groupValue forKey:@"group_value"];
    [param setValue:_groupKey forKey:@"group_key"];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityGroupMentoList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            if([[[result objectAtIndex:0] objectForKey:@"mento_total"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                _currentLastPageStatus = YES;
            }else{
                _currentLastPageStatus = NO;
            }
            
            [_tableListController.personList removeAllObjects];
            [_tableListController.personList addObjectsFromArray:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }else{
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}

- (void)setListMore:(NSNumber *)searchPage{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:searchPage forKey:@"searchPage"];
    [param setValue:_groupValue forKey:@"group_value"];
    [param setValue:_groupKey forKey:@"group_key"];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityGroupMentoList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            _searchPage = searchPage;
            
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            if([[[result objectAtIndex:0] objectForKey:@"mento_total"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                _currentLastPageStatus = YES;
            }else{
                _currentLastPageStatus = NO;
            }
            
            [_tableListController.personList addObjectsFromArray:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }else{
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}


#pragma mark navigation Action
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark profile delegate
- (void)moveNewspeedViewAction:(NSString *)mento_id mentoNickName:(NSString *)mento_nickname{
    _mento_id = mento_id;
    _mento_nickname = mento_nickname;
    [self performSegueWithIdentifier:@"UnwindingSegue" sender:self];
}

- (void)moveWriteMessageViewAction:(id)sender{   // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageWriteController"];
    [[self navigationController] pushViewController:messageNavigationController animated:YES];
}



@end
