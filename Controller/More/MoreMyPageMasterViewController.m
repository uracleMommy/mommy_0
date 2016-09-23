//
//  MoreMyPageMasterViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageMasterViewController.h"

@interface MoreMyPageMasterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewBottomConstraint;

@end

@implementation MoreMyPageMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    
    if (mainRect.size.height <= 480) {
        
        _infoViewTopConstraint.constant = _infoViewTopConstraint.constant - 17;
        _infoViewBottomConstraint.constant = _infoViewBottomConstraint.constant - 10;
    }
    
    //_infoViewTopConstraint.constant = _infoViewTopConstraint.constant - 17;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"containerTableView"]) {
        
        _moreMyPageSubInfoPanelController = segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"containerBlurView"]) {
        
        _moreMyPageSubImageController = segue.destinationViewController;
    }
}

#pragma mark 모달 창 관련

#pragma 닉네임 수정 모달
- (void) modalNickName {
    
    [self performSegueWithIdentifier:@"goNickNameChangeModal" sender:nil];
}

#pragma 태아 수정 모달
- (void) modalFetusChange {
    
    [self performSegueWithIdentifier:@"goFetusCountChangeModal" sender:nil];
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
