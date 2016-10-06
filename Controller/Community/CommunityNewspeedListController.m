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
//    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    
    //showPeople Button Setting
    UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *memberBtnImage = [UIImage imageNamed:@"title_icon_member.png"];
    memberBtn.frame = CGRectMake(0, 0, 40, 40);
    [memberBtn setImage:memberBtnImage forState:UIControlStateNormal];
    [memberBtn addTarget:self action:@selector(movePeopleList) forControlEvents:UIControlEventTouchUpInside];
    [memberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *memberButton = [[UIBarButtonItem alloc] initWithCustomView:memberBtn];
    self.navigationItem.rightBarButtonItem = memberButton;
}

- (void) viewWillAppear:(BOOL)animated {
    _moveWriteViewButton = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].size.width - 67.5, [[UIScreen mainScreen] applicationFrame].size.height - 52.5, 50, 50)];
    
    [_moveWriteViewButton setImage:[UIImage imageNamed:@"bottom_btn_write_n.png"] forState:UIControlStateNormal];
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_moveWriteViewButton];
    
    [_moveWriteViewButton addTarget:self action:@selector(moveWriteView) forControlEvents:UIControlEventTouchUpInside];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveWriteView{
    [_moveWriteViewButton removeFromSuperview];
    
    UIStoryboard *diaryStoryboard = [UIStoryboard storyboardWithName:@"Diary" bundle:nil];
    UINavigationController *diaryNavigationController = (UINavigationController *)[diaryStoryboard instantiateViewControllerWithIdentifier:@"DiaryWriteBasicController"];
    
    [self presentViewController:diaryNavigationController animated:YES completion:nil];
}

- (void)moveToMessage{
    NSLog(@"moveToMessage");
    
//    // MessageNaivgation
//    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
//    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageWriteController"];
 
    
//    [self presentViewController:messageNavigationController animated:YES completion:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    
    UINavigationController *messageNavigationController = [[UINavigationController alloc] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"MessageWriteController"]];
    [[self navigationController] pushViewController:messageNavigationController animated:YES];
}

- (void)toggleMentor{
    NSLog(@"toggleMentor");
}

-(void)goBack{
    [_moveWriteViewButton removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
}

- (void)moreButtonAction:(id)sender point:(CGPoint)point{
    NSLog(@"moreButton");
    
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

-(void) addMentor:(id)sender{
    NSLog(@"addMentor");
}
-(void) deleteMessage:(id)sender{
    NSLog(@"deleteMessage");
}

- (void)moveDetailViewButtonAction:(id)sender{
    [_moveWriteViewButton removeFromSuperview];
    [self performSegueWithIdentifier:@"moveShowDetailSegue" sender:self];
}

- (void)moveWriteMessageViewAction:(id)sender{
    [_moveWriteViewButton removeFromSuperview];
    // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageWriteController"];
    [[self navigationController] pushViewController:messageNavigationController animated:YES];
}


-(void)showProfilePopupViewAction:(id)sender{
    if (!_profilePopupView) {
        _profilePopupView = [[CommunityProfilePopupViewController alloc] initWithNibName:@"CommunityProfilePopupViewController" bundle:nil];
        _profilePopupView.delegate = self;
        _profilePopupView.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height+20);
    }
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:_profilePopupView.view];
}

- (void)movePeopleList{
    [_moveWriteViewButton removeFromSuperview];
    [self performSegueWithIdentifier:@"moveShowPeopleSegue" sender:self];
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)moveNewspeedViewAction:(id)sender{
    NSLog(@"moveNewspeed");
}

@end
