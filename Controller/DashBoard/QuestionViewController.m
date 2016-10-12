//
//  QuestionViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionScrollViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setKeyboardEnabled:NO];
}

- (void) viewDidLayoutSubviews {
    
    if ([_momWeek intValue] >= 21) {
        
        [self performSegueWithIdentifier:@"goQuestionScrollView21" sender:_momWeek];
    }
    else {
        
        [self performSegueWithIdentifier:@"goQuestionScrollView" sender:_momWeek];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitResult:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goQuestionScrollView21"] || [segue.identifier isEqualToString:@"goQuestionScrollView"]) {
        
        QuestionScrollViewController *questionScrollViewController = (QuestionScrollViewController *)segue.destinationViewController;
        questionScrollViewController.momWeek = _momWeek;
    }
}

@end
