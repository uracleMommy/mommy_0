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
    
    [self.sourceViewController.view addSubview:self.destinationViewController.view];
}

@end
