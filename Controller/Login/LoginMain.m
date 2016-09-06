//
//  LoginMain.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 9..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "LoginMain.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"

@interface LoginMain ()

@end

@implementation LoginMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    
    [self.navigationItem setHidesBackButton:YES];

    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backButton;
    
    //id field Setting
    UIImage *idFieldImage = [UIImage imageNamed:@"login_id.png"];
    UIView *idFieldImageContainer = [[UIView alloc] init];
    [idFieldImageContainer setFrame:CGRectMake(0.0f, 0.0f, 30, 30)];
    
    UIImageView *idIcon = [[UIImageView alloc] init];
    [idIcon setImage:idFieldImage];
    [idIcon setFrame:CGRectMake(0.0f, 0.0f, 30, 30)];
    
    [idFieldImageContainer addSubview:idIcon];
    
    [_idTextField setLeftView:idFieldImageContainer];
    [_idTextField setLeftViewMode:UITextFieldViewModeAlways];
    
    //pw field Setting
    UIImage *pwFieldImage = [UIImage imageNamed:@"login_pw.png"];
    UIView *pwFieldImageContainer = [[UIView alloc] init];
    [pwFieldImageContainer setFrame:CGRectMake(0.0f, 0.0f, 30, 30)];
    
    UIImageView *pwIcon = [[UIImageView alloc] init];
    [pwIcon setImage:pwFieldImage];
    [pwIcon setFrame:CGRectMake(0.0f, 0.0f, 30, 30)];
    
    [pwFieldImageContainer addSubview:pwIcon];
    
    [_pwTextField setLeftView:pwFieldImageContainer];
    [_pwTextField setLeftViewMode:UITextFieldViewModeAlways];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack {
    //임시로 계정 잠금 화면으로 이동
    [self performSegueWithIdentifier:@"moveLoginUnlockAccount" sender:self];
}

-(IBAction)clickAutoLoginButton:(id)sender {
    UIImage *autoLoginOffImage = [UIImage imageNamed:@"login_checkbox_off.png"];
    UIImage *autoLoginOnImage = [UIImage imageNamed:@"login_checkbox_on.png"];
    
    NSData *autoLoginClickImage = UIImagePNGRepresentation(_autoLoginImage.image);
    NSData *autoLoginOffImageData = UIImagePNGRepresentation(autoLoginOffImage);
    
    BOOL isCompare =  [autoLoginClickImage isEqual:autoLoginOffImageData];
    if(isCompare)
    {
        [_autoLoginImage setImage:autoLoginOnImage];
    }
    else
    {
        [_autoLoginImage setImage:autoLoginOffImage];
        NSLog(@"Image View doesn't contains image.png");
    }
}

- (IBAction)loginButtonAction:(id)sender {
    //TEMP 대쉬보드 이동
    UIStoryboard *dashBoardStoryboard = [UIStoryboard storyboardWithName:@"MainTabBar" bundle:nil];
    UINavigationController *dashBoardNavigationController = (UINavigationController *)[dashBoardStoryboard instantiateViewControllerWithIdentifier:@"MainTabBarNavigation"];
    
    [self presentViewController:dashBoardNavigationController animated:YES completion:nil];
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
