//
//  CoffeeCall.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CoffeeCall.h"
#import "Coffee.h"

@implementation CoffeeCall

- (id) init {
    
    if (self = [super init]) {
        
        Coffee *coffee = [[Coffee alloc] init];
        
        if (coffee.Empty)
        {
            [coffee Refill];
        }
        else
        {
            [coffee Drink];
        }
        
        // I am IOS Developer
    }
    
    return self;
}



@end
