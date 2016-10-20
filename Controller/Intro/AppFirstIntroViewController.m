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
                        //TODO
//                        [self performSegueWithIdentifier:@"moveMommyInfoSegue" sender:self];
                    });
                }
            }else{
                //로그인 실패
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                    message:@"로그인에 실패하셨습니다.\n로그인 화면으로 이동합니다."
                                                                   delegate:self
                                                          cancelButtonTitle:@"취소"
                                                          otherButtonTitles:nil, nil];
                    //                [alert setTag:1];
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
        [appDelegate go_story_board:@"MembershipLogin"];
    }
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

@end
