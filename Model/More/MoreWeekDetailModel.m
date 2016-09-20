//
//  MoreWeekDetailModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 12..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreWeekDetailModel.h"
#import "MoreWeekDetailInfoCell.h"

@implementation MoreWeekDetailModel

- (id) init {
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreWeekDetailInfoCell = @"MoreWeekDetailInfoCell";
    
    UINib *reuseMoreWeekDetailInfoCell = [UINib nibWithNibName:@"MoreWeekDetailInfoCell" bundle:nil];
    [tableView registerNib:reuseMoreWeekDetailInfoCell forCellReuseIdentifier:CellIdentifierMoreWeekDetailInfoCell];
    
    MoreWeekDetailInfoCell *cell = (MoreWeekDetailInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreWeekDetailInfoCell];
    
    if (cell == nil) {
        
        cell = (MoreWeekDetailInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreWeekDetailInfoCell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

@end
