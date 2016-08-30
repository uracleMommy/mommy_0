//
//  WeekProgramModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 30..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeekProgramModel.h"

@implementation WeekProgramModel

- (id) init {
    
    if (self = [super init]) {
        
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end