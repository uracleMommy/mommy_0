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
    _tableView.estimatedRowHeight = 68.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
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
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, messageButton, mentorButton, nil];
    
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
    
    self.navigationItem.title = _titleText;
    
    _cachedImages = [[NSMutableDictionary alloc]init];
    
    [self setListFirst];
}

- (void) viewWillAppear:(BOOL)animated {
    _moveWriteViewButton = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 67.5, [[UIScreen mainScreen] applicationFrame].size.height - 52.5, 50, 50)];
    
    [_moveWriteViewButton setImage:[UIImage imageNamed:@"bottom_btn_write_n.png"] forState:UIControlStateNormal];
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_moveWriteViewButton];
    
    [_moveWriteViewButton addTarget:self action:@selector(moveWriteView) forControlEvents:UIControlEventTouchUpInside];
    
    [self setList:@([_searchPage intValue]*[PAGE_SIZE intValue])];
}

#pragma mark - Navigation

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
//    if([[segue identifier] isEqualToString:@""]){
    self.navigationItem.title = _titleText;
    
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
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: negativeSpacer2, messageButton, mentorButton, nil];
    
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
//    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_moveWriteViewButton removeFromSuperview];
    if([[segue identifier] isEqualToString:@"moveShowPeopleSegue"]){
        CommunityPeopleListController *vc = [segue destinationViewController];
        [vc setGroupKey:_groupKey];
        [vc setGroupValue:_groupValue];
    }else if([[segue identifier] isEqualToString:@"moveShowDetailSegue"]){
        CommunityDetailController *vc = [segue destinationViewController];
        [vc setMotherData:_detailData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark navigation Action
- (void)moveToMessage{
//    [_moveWriteViewButton removeFromSuperview];
//    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
//    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
//    
//    [self presentViewController:messageNavigationController animated:YES completion:nil];
    [self moveWriteMessageView:_mentorKey mentoNickName:_titleText];
}

-(void)goBack{
    [_moveWriteViewButton removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)movePeopleList{
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
    
    [self performSegueWithIdentifier:@"moveWriteCommunitySegue" sender:self];
}

#pragma mark in table button Action
- (void)moveWriteMessageViewAction:(id)sender{
    [self moveWriteMessageView:[[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_key"] mentoNickName:[[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_nickname"]];
}

-(void) toggleMentor{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:_mentorKey forKey:@"mento_key"];
    
    UIButton *imageView = self.navigationItem.rightBarButtonItems[1].customView;
    
    UIImage *cancelImage = [UIImage imageNamed:@"title_icon_mentor_cancel.png"];
    UIImage *addImage = [UIImage imageNamed:@"title_icon_mentor_add.png"];
    
    NSData *clickImage = UIImagePNGRepresentation([imageView currentImage]);
    NSData *addImageData = UIImagePNGRepresentation(addImage);
    
    if([clickImage isEqual:addImageData]){
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self changedMento:0 insert:@"Y"];
                    [imageView setImage:cancelImage forState:UIControlStateNormal];
                });
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoDelete authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self changedMento:0 insert:@"N"];
                    [imageView setImage:addImage forState:UIControlStateNormal];
                });
            }
        } error:^(NSError *error) {
            
        }];
    }

}

- (void)moveDetailViewButtonAction:(NSDictionary *)data{
    _detailData = data;
    [self performSegueWithIdentifier:@"moveShowDetailSegue" sender:self];
}

#pragma mark KkMenu Setting
- (void)moreButtonAction:(id)sender point:(CGPoint)point{
    NSMutableArray *menuItems = [[NSMutableArray alloc] init];
    _cellTag = [sender tag];
    if([[[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_yn"] isEqualToString:@"N"]){
        [menuItems addObject:[KxMenuItem menuItem:@"멘토추가"
                                           target:self
                                           action: @selector(addMentor:)]];
    }else{
        [menuItems addObject:[KxMenuItem menuItem:@"멘토취소"
                                           target:self
                                           action: @selector(deleteMentor:)]];
    }
    
    if([[[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_id"] isEqualToString:GET_USER_ID]){
        [menuItems addObject:[KxMenuItem menuItem:@"삭제"
                                           target:self
                                           action:@selector(deleteMessage:)]];
    }
    
    if([menuItems count] == 0){
        return ;
    }
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(point.x, point.y-_tableView.contentOffset.y, 0, 0)
                 menuItems:menuItems];
    
    [KxMenu setTarget:self action:@selector(dismissMenu)];
    
}

-(void) addMentor:(id)sender{
    NSLog(@"addMentor");
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    int cellTag = _cellTag;

    [param setObject: [[_tableListController.newspeedList objectAtIndex:_cellTag] objectForKey:@"mento_key"] forKey:@"mento_key"];
    
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self changedMento:cellTag insert:@"Y"];
            });
        }
    } error:^(NSError *error) {
        
    }];
}

-(void) deleteMentor:(id)sender{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    int cellTag = _cellTag;
    [param setObject: [[_tableListController.newspeedList objectAtIndex:cellTag] objectForKey:@"mento_key"] forKey:@"mento_key"];
    
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoDelete authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self changedMento:cellTag insert:@"N"];
            });
        }
    } error:^(NSError *error) {
        
    }];
}

-(void) deleteMessage:(id)sender{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    int cellTag = _cellTag;
    
    [param setObject:[[_tableListController.newspeedList objectAtIndex:cellTag] objectForKey:@"community_key"] forKey:@"community_key"];
    
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityDelete authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_tableListController.newspeedList removeObjectAtIndex:cellTag];
                [_tableView reloadData];
            });
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark profile show & delegate
-(void)showProfilePopupViewAction:(id)sender{
    if (!_profilePopupView) {
        _profilePopupView = [[CommunityProfilePopupViewController alloc] initWithNibName:@"CommunityProfilePopupViewController" bundle:nil];
        _profilePopupView.delegate = self;
        _profilePopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    _profilePopupView.mentorKey = [[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_key"];
//    _profilePopupView.mentorId = [[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_id"];
    _profilePopupView.mentorNickname = [[_tableListController.newspeedList objectAtIndex:[sender tag]] objectForKey:@"mento_nickname"];
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_profilePopupView.view];
}

- (void)moveWriteMessageView:(NSString *)mento_key mentoNickName:(NSString *)mento_nickname{
    [_moveWriteViewButton removeFromSuperview];
    
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    MessageWriteController *messageNavigationController = [messageStoryboard instantiateViewControllerWithIdentifier:@"MessageWriteController"];
    
    messageNavigationController.toUserCode = mento_key;
    messageNavigationController.toUserNickname = mento_nickname;
    
    [[self navigationController] pushViewController:messageNavigationController animated:YES];
}

- (void)moveNewspeedViewAction:(NSString *)mento_id mentoNickName:(NSString *)mento_nickname{
    NSLog(@"moveNewspeed");
    _mode = MentorMode;
    _titleText = mento_nickname;
    _mentorKey = mento_id;
    [self prepareForUnwind:nil];
}

- (void)changedMento:(int)tableIndex insert:(NSString *)insert{
    NSString *user_key = [[_tableListController.newspeedList objectAtIndex:tableIndex] objectForKey:@"mento_key"];
    for( int i = 0 ; i<[_tableListController.newspeedList count] ; i++){
        
        if([[[_tableListController.newspeedList objectAtIndex:i] objectForKey:@"mento_key"] isEqualToString:user_key]){
            NSMutableDictionary *changedData = [_tableListController.newspeedList objectAtIndex:i];
            [changedData setValue:insert forKeyPath:@"mento_yn"];
            [_tableListController.newspeedList replaceObjectAtIndex:i withObject:changedData];
        }
    }
}


#pragma mark setting list
- (void)setListFirst{
    [self setList:PAGE_SIZE];
}

- (void)setList:(NSNumber *)pageSize{
    
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
    
    [param setValue:pageSize forKey:@"pageSize"];
    [param setValue:_searchPage forKey:@"searchPage"];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:service authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            if([result count] == 0){
                NSLog(@"empty");
                if(!_noDataController){
                    _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataCommunityController"];
                    [_noDataController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                    _noDataController.view.tag = 2;
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.view addSubview : _noDataController.view];
                    _tableView.hidden = YES;
                });
            }else{
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    _tableView.hidden = NO;
                    if(self.view.subviews[0].tag == 2){
                        [self.view.subviews[0] removeFromSuperview];
                    }
                });
                
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
            }
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
            }else{
                if([[[result objectAtIndex:0] objectForKey:@"tot_cnt"] intValue] >= [_searchPage intValue]+[PAGE_SIZE intValue] ){
                    _currentLastPageStatus = YES;
                }else{
                    _currentLastPageStatus = NO;
                }
                
                [_tableListController.newspeedList addObjectsFromArray:result];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }
        }else{
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}


- (void)collectionView:(NSDictionary *)imageArr didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedCell:(id)sender{
    NSLog(@"PSH collectionView didSelecte : %li", (long)indexPath.row);
    long cellIndex = (long)[_tableView indexPathForCell:sender].row;
//    NSString *fileName = [[[_tableListController.newspeedList objectAtIndex:(int)cellIndex] objectForKey:@"files"] objectAtIndex:indexPath.row];
    
    _imageViewer = [[MultiImageViewController alloc] init];
    
    NSArray *imgNameArray = [[_tableListController.newspeedList objectAtIndex:(int)cellIndex] objectForKey:@"files"];
    
    NSMutableArray *uiImageArr = [[NSMutableArray alloc] init];
    
    for(int i=0 ; i<[imgNameArray count] ; i++){
        
        NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [[imgNameArray objectAtIndex:i] objectForKey:@"file_name"]];
        
            if([imageArr objectForKey:profileImageIdentifier] != nil){
                [uiImageArr addObject:[imageArr valueForKey:profileImageIdentifier]];
            }
    }
    
    _imageViewer.imgArray = [[NSArray alloc] initWithArray:uiImageArr];
    _imageViewer.index = (int)indexPath.row;
    [_moveWriteViewButton removeFromSuperview];
    [self presentViewController:_imageViewer animated:YES completion:nil];

}

@end
