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
    
    [self performSegueWithIdentifier:@"goAdviceContent" sender:nil];
    
    _detailContentViewController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews {
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    
}

#pragma 문의 콜백 함수
- (void) imageArray:(NSArray *)imageArray startIndex:(NSInteger)startIndex {
    
    _multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
    _multiImageViewController.imgArray = [NSArray arrayWithArray:imageArray];
    _multiImageViewController.index = (int)startIndex;
    
    [self presentViewController:_multiImageViewController animated:YES completion:nil];
}


- (IBAction)goAdvice:(id)sender {
    
    [_moreProfessionalReplyContentsViewController.view removeFromSuperview];
    
    [self performSegueWithIdentifier:@"goAdviceContent" sender:nil];
    
}

- (IBAction)goReply:(id)sender {
    
    // 제거
    [_detailContentViewController.view removeFromSuperview];
    
    [self performSegueWithIdentifier:@"goReplyContent" sender:nil];
    
}

@end
