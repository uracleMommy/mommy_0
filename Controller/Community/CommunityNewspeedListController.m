//
//  CommunityNewspeedListController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 28..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityNewspeedListController.h"

@interface CommunityNewspeedListController ()

@end

@implementation CommunityNewspeedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.hidesBackButton = YES;
    
    
    _searchPage = [[NSNumber alloc] initWithInt:1];
    _currentLastPageStatus = NO;
    
    _tableListController = [[CommunityNewspeedListModel alloc] init];
    
    _tableListController.delegate = self;
    _tableView.delegate = _tableListController;
    _tableView.dataSource = _tableListController;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
    
    
    //mentor Button Setting
    UIButton *mentorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *mentorBtnImage = [UIImage imageNamed:@"title_icon_mentor_cancel.png"];
    mentorBtn.frame = CGRectMake(0, 0, 40, 40);
    [mentorBtn setImage:mentorBtnImage forState:UIControlStateNormal];
    [mentorBtn addTarget:self action:@selector(toggleMentor) forControlEvents:UIControlEventTouchUpInside];
//    [mentorBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    UIBarButtonItem *mentorButton = [[UIBarButtonItem alloc] initWithCustomView:mentorBtn];
    
    //message Button Setting
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *messageBtnImage = [UIImage imageNamed:@"title_icon_message.png"];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    [messageBtn setImage:messageBtnImage forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(moveToMessage) forControlEvents:UIControlEventTouchUpInside];
    //    [messageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    UIBarButtonItem *messageButton = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = -16;
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, mentorButton, messageButton, nil];
    
    //showPeople Button Setting
    UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *memberBtnImage = [UIImage imageNamed:@"title_icon_member.png"];
    memberBtn.frame = CGRectMake(0, 0, 40, 40);
    [memberBtn setImage:memberBtnImage forState:UIControlStateNormal];
    [memberBtn addTarget:self action:@selector(movePeopleList) forControlEvents:UIControlEventTouchUpInside];
    [memberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *memberButton = [[UIBarButtonItem alloc] initWithCustomView:memberBtn];
    
    if(_mode == MentorMode){
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }else{
        self.navigationItem.rightBarButtonItems = @[memberButton];
    }
    
    [self setListFirst];
}

- (void) viewWillAppear:(BOOL)animated {
    _moveWriteViewButton = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 67.5, [[UIScreen mainScreen] applicationFrame].size.height - 52.5, 50, 50)];
    
    [_moveWriteViewButton setImage:[UIImage imageNamed:@"bottom_btn_write_n.png"] forState:UIControlStateNormal];
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_moveWriteViewButton];
    
    [_moveWriteViewButton addTarget:self action:@selector(moveWriteView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Navigation

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_moveWriteViewButton removeFromSuperview];
    
    if([[segue identifier] isEqualToString:@"moveShowPeopleSegue"]){
        CommunityPeopleListController *vc = [segue destinationViewController];
        [vc setGroupKey:_groupKey];
        [vc setGroupValue:_groupValue];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark navigation Action
- (void)moveToMessage{
    [_moveWriteViewButton removeFromSuperview];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    
    UINavigationController *messageNavigationController = [[UINavigationController alloc] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"MessageWriteController"]];
    [[self navigationController] pushViewController:messageNavigationController animated:YES];
}

-(void)goBack{
    [_moveWriteViewButton removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)movePeopleList{
//    [_moveWriteViewButton removeFromSuperview];
    [self performSegueWithIdentifier:@"moveShowPeopleSegue" sender:self];
}

#pragma mark tableView delegate
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger)count{
    if (!_currentLastPageStatus) {
        return;
    }
    
    [self setListMore:[[NSNumber alloc] initWithInt:([_searchPage intValue]+[PAGE_SIZE intValue]) ]];
    
}

-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
}

-(void)moveWriteView{
    [_moveWriteViewButton removeFromSuperview];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Diary" bundle:nil];
    
    UINavigationController *diaryNavigationController = [[UINavigationController alloc] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"DiaryWriteBasicController"]];
    [[self navigationController] pushViewController:diaryNavigationController animated:YES];
}

#pragma mark in table button Action
- (void)moreButtonAction:(id)sender point:(CGPoint)point{
  
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"멘토추가"
                    target:self
                    action:@selector(addMentor:)],
      
      [KxMenuItem menuItem:@"삭제"
                    target:self
                    action:@selector(deleteMessage:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(point.x, point.y-_tableView.contentOffset.y, 0, 0)
     
                 menuItems:menuItems];
    
    [KxMenu setTarget:self action:@selector(dismissMenu)];
    
}

- (void)toggleMentor{
    NSLog(@"toggleMentor");
}

-(void) addMentor:(id)sender{
    NSLog(@"addMentor");
}
-(void) deleteMessage:(id)sender{
    NSLog(@"deleteMessage");
}

- (void)moveDetailViewButtonAction:(id)sender{
//    [_moveWriteViewButton removeFromSuperview];
    [self performSegueWithIdentifier:@"moveShowDetailSegue" sender:self];
}

#pragma mark profile show & delegate
-(void)showProfilePopupViewAction:(id)sender{
    if (!_profilePopupView) {
        _profilePopupView = [[CommunityProfilePopupViewController alloc] initWithNibName:@"CommunityProfilePopupViewController" bundle:nil];
        _profilePopupView.delegate = self;
        _profilePopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    _profilePopupView.mentorKey = @"test40";
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_profilePopupView.view];
}

- (void)moveWriteMessageViewAction:(id)sender{
    [_moveWriteViewButton removeFromSuperview];
    // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageWriteController"];
    [[self navigationController] pushViewController:messageNavigationController animated:YES];
}

- (void)moveNewspeedViewAction:(id)sender{
    NSLog(@"moveNewspeed");
}


#pragma mark setting list
- (void)setListFirst{
    _searchPage = [[NSNumber alloc]initWithInt:1];
    
    MommyCommunityWebServiceType service;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    if(_mode == GroupMode){
        service = CommunityGroupBoardList;
        [param setValue:_groupValue forKey:@"group_value"];
        [param setValue:_groupKey forKey:@"group_key"];
    }else{
        service = CommunityMentoBoardList;
        [param setValue:_mentorKey forKey:@"mento_key"];
    }
    
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:_searchPage forKey:@"searchPage"];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:service authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            
            if([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= ([_searchPage intValue]+[PAGE_SIZE intValue]) ){
                _currentLastPageStatus = YES;
            }else{
                _currentLastPageStatus = NO;
            }
            
            [_tableListController.newspeedList removeAllObjects];
            [_tableListController.newspeedList addObjectsFromArray:result];
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
    MommyCommunityWebServiceType service;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];

    if(_mode == GroupMode){
        service = CommunityGroupBoardList;
        [param setValue:_groupValue forKey:@"group_value"];
        [param setValue:_groupKey forKey:@"group_key"];
    }else{
        service = CommunityMentoBoardList;
        [param setValue:_mentorKey forKey:@"mento_key"];
    }
    
    [param setValue:PAGE_SIZE forKey:@"pageSize"];
    [param setValue:searchPage forKey:@"searchPage"];
    
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:service authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            _searchPage = searchPage;
            
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
            }
            if([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                _currentLastPageStatus = YES;
            }else{
                _currentLastPageStatus = NO;
            }
            
            [_tableListController.newspeedList addObjectsFromArray:result];
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

@end
