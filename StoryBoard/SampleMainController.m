//
//  SampleMainController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SampleMainController.h"
#import "SingleImageViewController.h"
#import "MultiImageViewController.h"

@interface SampleMainController ()



@end

@implementation SampleMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)memberResist:(id)sender {
    
    NSString *storyboard_name = @"MembershipSignUp";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    
    NSString *storyboard_name = @"MembershipLogin";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)diary:(id)sender {
    
    NSString *storyboard_name = @"Diary";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)message:(id)sender {
    
    NSString *storyboard_name = @"Message";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)pushNotice:(id)sender {
    
    NSString *storyboard_name = @"PushNotice";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)singleImageView:(id)sender {
    
    SingleImageViewController *singleImageViewController = [[SingleImageViewController alloc] initWithNibName:@"SingleImageViewController" bundle:nil];
    
    [self presentViewController:singleImageViewController animated:YES completion:nil];
}

- (IBAction)multiImageView:(id)sender {
    
    MultiImageViewController *multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
    
    [self presentViewController:multiImageViewController animated:YES completion:nil];
}

- (IBAction)weekProgram:(id)sender {
    
    
}

@end
