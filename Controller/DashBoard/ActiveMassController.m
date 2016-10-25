//
//  ActiveMassController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassController.h"
#import "ExerciseCountDownController.h"

@interface ActiveMassController ()

@end

@implementation ActiveMassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 우측버튼
    UIButton *professionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close"];
    professionButton.frame = CGRectMake(0, 0, 40, 40);
    [professionButton setImage:closeBtnImage forState:UIControlStateNormal];
    [professionButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *adviceItemButton = [[UIBarButtonItem alloc] initWithCustomView:professionButton];
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, adviceItemButton]];
    
    NSArray *items = @[@"일자별", @"주차별"];
    _dayWeekTypeSegment.items = items;
    
    _dayWeekTypeSegment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _dayWeekTypeSegment.delegate = self;
    _dayWeekTypeSegment.selectedSegmentIndex = 0;
    
    [_dayWeekTypeSegment setShowsCount:NO];
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    [_dayWeekTypeSegment setFrame:CGRectMake(0, 0, screenSize.size.width, 44)];
    
    _activeMassModel = [[ActiveMassModel alloc] init];
    
    _tableView.dataSource = _activeMassModel;
    _tableView.delegate = _activeMassModel;
    
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)goExerciseTimer:(id)sender {
    
    UIStoryboard *dashBoardStoryboard = [UIStoryboard storyboardWithName:@"DashBoard" bundle:nil];    
    UIViewController *exerciseCountDownController = [dashBoardStoryboard instantiateViewControllerWithIdentifier:@"ExerciseCountDown"];
    
    
    CGRect size = [[UIScreen mainScreen] bounds];
    [exerciseCountDownController.view setFrame:size];
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:exerciseCountDownController.view];
}

@end
