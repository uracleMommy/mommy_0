//
//  MorePrefessionalEmptySegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MorePrefessionalEmptySegue.h"

@implementation MorePrefessionalEmptySegue

- (void) perform {
    
    [self.sourceViewController.view addSubview:self.destinationViewController.view];
}

@end
