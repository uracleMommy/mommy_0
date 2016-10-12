//
//  MoreProfessionalReplyContentSegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalReplyContentSegue.h"

@implementation MoreProfessionalReplyContentSegue

- (void) perform {
    
    MoreProfessionalDetailViewController *moreProfessionalDetailViewController = (MoreProfessionalDetailViewController *)self.sourceViewController;
    moreProfessionalDetailViewController.moreProfessionalAdviceReplyViewController  = self.destinationViewController;
    
    [moreProfessionalDetailViewController.moreProfessionalAdviceReplyViewController.view setFrame:CGRectMake(0, 0, moreProfessionalDetailViewController.containerView.frame.size.width, moreProfessionalDetailViewController.containerView.frame.size.height)];
    [moreProfessionalDetailViewController.containerView addSubview:moreProfessionalDetailViewController.moreProfessionalAdviceReplyViewController.view];
}

@end
