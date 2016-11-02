//
//  AppFirstIntroViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 10. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "AppFirstIntroViewController.h"

@interface AppFirstIntroViewController ()

@end

@implementation AppFirstIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:nil];
//    UINavigationController *navigationController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpMommyInfoController"];
//    [[self navigationController] pushViewController:navigationController animated:YES];
    if([[userDefaults objectForKey:@"autoLoginFlag"] isEqualToString:@"Y"]){
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:[userDefaults objectForKey:@"userId"] forKey:@"id"];
        [param setValue:[userDefaults objectForKey:@"userPw"] forKey:@"password"];
        
        dispatch_async(dispatch_get_main_queue(), ^{[self showIndicator];});
        [[MommyRequest sharedInstance] mommyLoginApiService:LoginCheck authKey:nil parameters:param success:^(NSDictionary *data){
            NSLog(@"PSH data %@", data);
            
            NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
            if([code isEqual:@"0"]){
                NSDictionary *result = [[NSDictionary alloc] initWithDictionary:[data objectForKey:@"result"]];
                
                GET_AUTH_TOKEN = [result objectForKey:@"token"];
                GET_USER_ID = [result objectForKey:@"id"];
                
                if([[result objectForKey:@"profile_yn"] isEqual:@"Y"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        [appDelegate go_story_board:@"MainTabBar"];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MembershipLogin" bundle:[NSBundle mainBundle]];
                        UINavigationController *vc = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpMommyInfoController"];
                        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        // Set root view controller and make windows visible
                        appDelegate.window.rootViewController = vc;
                        [appDelegate.window makeKeyAndVisible];
                    });
                }
            }else{
                //로그인 실패
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"로그인에 실패하셨습니다.\n인트로 화면으로 이동합니다."
                                                                   delegate:self
                                                          cancelButtonTitle:@"취소"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } error:^(NSError *error) {
            NSLog(@"PSH error %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
        } ];
    }else{
        AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate go_story_board:@"Intro"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate go_story_board:@"Intro"];
}



@end
