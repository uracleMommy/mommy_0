//
//  CommunityMainController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityMainController.h"

@interface CommunityMainController ()

@end

@implementation CommunityMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //navigation setting
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = @"커뮤니티";
    
    
    //tab setting
    NSArray *items = @[@"MY", @"멘토"];
    _tabView.items = items;
    _tabView.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _tabView.delegate = self;
    _tabView.selectedSegmentIndex = 0;
    [_tabView setShowsCount:NO];
    
    [_tabView addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    [_tabView setFrame:CGRectMake(0, 0, screenSize.size.width, 40)];
    
    
    //message Button Setting
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *messageBtnImage = [UIImage imageNamed:@"title_icon_message.png"];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    [messageBtn setImage:messageBtnImage forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(moveToMessage) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    UIBarButtonItem *messageButton = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    //alarm Button Setting
    UIButton *alarmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *alarmBtnImage = [UIImage imageNamed:@"title_icon_alarm.png"];
    alarmBtn.frame = CGRectMake(0, 0, 40, 40);
    [alarmBtn setImage:alarmBtnImage forState:UIControlStateNormal];
    [alarmBtn addTarget:self action:@selector(moveToAlarm) forControlEvents:UIControlEventTouchUpInside];
    [alarmBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *alarmButton = [[UIBarButtonItem alloc] initWithCustomView:alarmBtn];
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: alarmButton, messageButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}
    
- (void)didChangeSegment:(DZNSegmentedControl *)control
{
    [_contentView.subviews[0] removeFromSuperview];
    
    if([control selectedSegmentIndex] == 0){
        [_contentView addSubview : _myGroupViewController.view];
        
    }else{
        if(!_mentorViewController){
            _mentorViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CommunityMentorView"];
            [_mentorViewController.view setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
            
            _mentorViewController.delegate = self;
        }
        
        [_contentView addSubview : _mentorViewController.view];
        

    }
//    [control setFont:[UIFont fontWithName:@"NanumBarunGothicBold" size:15.0f]];
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
-(void)viewDidAppear:(BOOL)animated{
    if(!_myGroupViewController){
        _myGroupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CommunityMyGroupView"];
        
        //        _contentViewController.delegate = self;
        _myGroupViewController.delegate = self;
        [_myGroupViewController.view setFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
        
        [_contentView addSubview : _myGroupViewController.view];
        
        //        [_scrollView sizeToFit];
    }
}


- (void)moveToMessage{
    NSLog(@"moveToMessage");
    
    // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
    
    
}

- (void)moveToAlarm{
    NSLog(@"moveToAlarm");
    
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"PushNotice" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"PushListNavigation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (void)moveCommunityList{
    [self performSegueWithIdentifier:@"showListCommunitySegue" sender:self];
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
