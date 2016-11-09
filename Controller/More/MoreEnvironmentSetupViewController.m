//
//  MoreEnvironmentSetupViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEnvironmentSetupViewController.h"

@interface MoreEnvironmentSetupViewController ()

@end

@implementation MoreEnvironmentSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
    
    _moreEnvironmentListModel = [[MoreEnvironmentListModel alloc] init];
    _moreEnvironmentListModel.delegate = self;
    _tableView.dataSource = _moreEnvironmentListModel;
    _tableView.delegate = _moreEnvironmentListModel;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goMypageManagement"]){
        UINavigationController *navController = [segue destinationViewController];
        MoreMyPageMasterViewController *vc = (MoreMyPageMasterViewController *)([navController viewControllers][0]);
        
        [vc setResult:_myPageInfo];
        
    }
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(alertView.tag == 0){
        switch (buttonIndex) {
            case 1 : {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                
                if([[userDefaults objectForKey:@"autoLoginFlag"] isEqualToString:@"Y"]){
                    [userDefaults setObject:@"N" forKey:@"autoLoginFlag"];
                    [userDefaults synchronize];
                }
                
                
                AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate go_story_board:@"Intro"];

            }
                
            default:
                break;
        }
//    }
}


- (IBAction)logoutButtonAction:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                    message:@"서비스를 종료하고 로그아웃 하시겠습니까?"
                                                   delegate:self
                                          cancelButtonTitle:@"취소"
                                          otherButtonTitles:@"로그아웃", nil];
    [alert show];
}

- (void) tableView:(UITableView *)tableView MoreMyPageModelSelectedIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"goMypageManagement2" sender:nil];
    }else if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"goCalendarConnectList" sender:nil];
    }
}

@end















