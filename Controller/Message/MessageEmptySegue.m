//
//  MessageEmptySegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MessageEmptySegue.h"

@implementation MessageEmptySegue

- (void) perform {
    
    [self.sourceViewController.view addSubview:self.destinationViewController.view];
}

@end
