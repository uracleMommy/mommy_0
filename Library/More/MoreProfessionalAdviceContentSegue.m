//
//  MoreProfessionalAdviceContentSegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalAdviceContentSegue.h"

@implementation MoreProfessionalAdviceContentSegue

- (void) perform {
    
    MoreProfessionalDetailViewController *moreProfessionalDetailViewController = (MoreProfessionalDetailViewController *)self.sourceViewController;
    moreProfessionalDetailViewController.detailContentViewController = self.destinationViewController;
    moreProfessionalDetailViewController.detailContentViewController.delegate = moreProfessionalDetailViewController;
    
    [moreProfessionalDetailViewController.detailContentViewController.view setFrame:CGRectMake(0, 0, moreProfessionalDetailViewController.containerView.frame.size.width, moreProfessionalDetailViewController.containerView.frame.size.height)];
    [moreProfessionalDetailViewController.containerView addSubview:moreProfessionalDetailViewController.detailContentViewController.view];    
}

@end
