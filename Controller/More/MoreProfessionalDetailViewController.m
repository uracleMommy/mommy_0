//
//  MoreProfessionalDetailViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalDetailViewController.h"


@interface MoreProfessionalDetailViewController ()

@end

@implementation MoreProfessionalDetailViewController

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
    
    [_segmentView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    _segmentView.items = @[@"상담내용", @"답변내용"];
    _segmentView.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _segmentView.selectedSegmentIndex = 0;
    
    [_segmentView setShowsCount:NO];
    
    //[self performSegueWithIdentifier:@"goAdviceContent" sender:nil];
    
    [_segmentView addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    
    [self performSegueWithIdentifier:@"goAdviceContent" sender:nil];
}

- (void) closeModal {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) selectedSegment:(id) sender {
    
    DZNSegmentedControl *control = (DZNSegmentedControl *)sender;
    
    if(control.selectedSegmentIndex == 0) {
        
        [_moreProfessionalReplyContentsViewController.view removeFromSuperview];
        [self performSegueWithIdentifier:@"goAdviceContent" sender:nil];
        
    }
    else {
        // 제거
        [_detailContentViewController.view removeFromSuperview];
        [self performSegueWithIdentifier:@"goReplyContent" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"goAdviceContent"]) {
        
        MoreProfessionalAdviceContentsViewController *moreProfessionalAdviceContentsViewController = (MoreProfessionalAdviceContentsViewController *)segue.destinationViewController;
        
        // 넘겨줄 테이터
        
        
    }
    else {
        
    }
}

#pragma 문의 콜백 함수
- (void) imageArray:(NSArray *)imageArray startIndex:(NSInteger)startIndex {
    
    _multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
    _multiImageViewController.imgArray = [NSArray arrayWithArray:imageArray];
    _multiImageViewController.index = (int)startIndex;
    
    [self presentViewController:_multiImageViewController animated:YES completion:nil];
}

@end
