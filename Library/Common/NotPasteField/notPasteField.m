//
//  notPasteField.m
//  kdstudent
//
//  Created by OGGU on 2016. 1. 5..
//  Copyright © 2016년 OGGU. All rights reserved.
//

#import "notPasteField.h"

@implementation notPasteField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    
    return NO;
}

@end
