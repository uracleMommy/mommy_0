//
//  QuestionScrollViewSegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "QuestionScrollViewSegue.h"
#import "QuestionViewController.h"



@implementation QuestionScrollViewSegue

- (void) perform {
    
    QuestionViewController *questionViewController = self.sourceViewController;
    questionViewController.questionScrollViewController = self.destinationViewController;
    [questionViewController.scrollView setFrame:questionViewController.scrollContainerView.frame];
    QuestionScrollViewController *questionScrollViewController = self.destinationViewController;
    
    if (questionViewController.scrollContainerView.frame.size.height > 453) {
        [questionScrollViewController.view setFrame:CGRectMake(0, 0, questionViewController.scrollContainerView.frame.size.width, questionViewController.scrollContainerView.frame.size.height)]; // 문진정보 컨트롤러
    }
    else {
        [questionScrollViewController.view setFrame:CGRectMake(0, 0, questionViewController.scrollContainerView.frame.size.width, 453)]; // 문진정보 컨트롤러
    }
    
    
    [questionViewController.scrollView addSubview:questionScrollViewController.view];
    
//    [questionViewController.scrollView sizeToFit];
}

@end
