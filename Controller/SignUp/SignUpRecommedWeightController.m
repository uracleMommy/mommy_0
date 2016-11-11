//
//  SignUpRecommedWeightController.m
//  co.medisolution
//
//  Created by uracle on 2016. 11. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpRecommedWeightController.h"

@interface SignUpRecommedWeightController ()

@end

@implementation SignUpRecommedWeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView.delegate = self;
    for (id subview in _webView.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
//    
//    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    
//    [param setObject:@(68.0) forKey:@"before_weight"];
//    [param setObject:@(58.0) forKey:@"weight"];
//    [param setObject:@"20170505" forKey:@"baby_birth"];
//    [param setObject:@(156) forKey:@"height"];
//    [param setObject:@"2" forKey:@"baby_cnt"];
    
    NSLog(@"%@", _param);
    [[MommyRequest sharedInstance] mommySignInApiService:RecommendWeight authKey:GET_AUTH_TOKEN parameters:_param success:^(NSDictionary *data) {
//        NSLog(@"PSH : %@", [data objectForKey:@"msg"]);
        if([[data objectForKey:@"code"] intValue] == 0){
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self.navigationItem.title = [NSString stringWithFormat:@"임신 %@주", data[@"result"][@"weight_info"][@"mom_week"]];
                
                _titleLabel.text = [NSString stringWithFormat:@"권장체중은 %@ kg ~ %@ kg로 %@입니다.\n일일 %@ ~ %@보 걷기를 권장합니다.", data[@"result"][@"weight_info"][@"min_weight"], data[@"result"][@"weight_info"][@"max_weight"], data[@"result"][@"weight_info"][@"weight_stauts"], data[@"result"][@"step_info"][@"min"], data[@"result"][@"step_info"][@"max"]];
                
                // 차트 바인딩
                NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"recommend_weight" ofType:@"html"]];
                NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
                
                // 테이블 리로드
                NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:data[@"result"]];
                [resultDic setValue:@([UIScreen mainScreen].bounds.size.width - 55) forKey:@"width"];
                [resultDic setValue:@(180) forKey:@"height"];
                
                NSError *error;
                NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:resultDic options:0 error:&error];
                _functionJson = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
                NSLog(@"%@",_functionJson);
                
                // 자바스크립트 펑션 호출
                _isFirst = YES;
                [_webView loadRequest:request];
            });

        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                                message:[data objectForKey:@"msg"]
                                                               delegate:self
                                                      cancelButtonTitle:@"확인"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            });

        }
    } error:^(NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                            message:@"서버 통신 중 에러가 발생하였습니다. 다시 시도해주시기 바랍니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        });
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (_isFirst) {
        
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initChart('%@')", _functionJson]];
        _isFirst = NO;
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

- (IBAction)moveDashBoard:(id)sender {
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate go_story_board:@"MainTabBar"];
//    UIStoryboard *mainTabBarStoryboard = [UIStoryboard storyboardWithName:@"MainTabBar" bundle:nil];
    //                UINavigationController *mainTabBarNavigationController = (UINavigationController *)[mainTabBarStoryboard instantiateViewControllerWithIdentifier:@"MainTabBarNavigation"];
    //
    //                [self presentViewController:mainTabBarNavigationController animated:YES completion:nil];
}
@end
