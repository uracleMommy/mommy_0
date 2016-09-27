//
//  QuestionViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setKeyboardEnabled:NO];
}

- (void) viewDidLayoutSubviews {
    
    [self performSegueWithIdentifier:@"goQuestionScrollView" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitResult:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
