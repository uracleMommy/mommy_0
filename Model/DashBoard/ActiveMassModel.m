//
//  ActiveMassModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassModel.h"

@implementation ActiveMassModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_arrayList.count > 0) {
        
        // 차트셀 + 인포셀 헤더 풋터
        return 2;
    }
    else {
        
        // 차트 셀 한개는 리턴이 되어야 함
        return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 0;
//}

@end