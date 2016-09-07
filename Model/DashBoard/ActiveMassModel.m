//
//  ActiveMassModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassModel.h"
#import "ActiveMassChartView.h"
#import "ActiveMassStepCell.h"
#import "ActiveMassCalorieCell.h"
#import "ActiveMassExerciseCell.h"

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
    
    return 4;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierActiveMassChartViewCell = @"ActiveMassChartView";
    static NSString *CellIdentifierActiveMassStepCell = @"ActiveMassStepCell";
    static NSString *CellIdentifierActiveMassCalorieCell = @"ActiveMassCalorieCell";
    static NSString *CellIdentifierActiveMassExerciseCell = @"ActiveMassExerciseCell";
    
    UINib *reuseActiveMassChartViewCell = [UINib nibWithNibName:@"ActiveMassChartView" bundle:nil];
    [tableView registerNib:reuseActiveMassChartViewCell forCellReuseIdentifier:CellIdentifierActiveMassChartViewCell];
    
    UINib *reuseActiveActiveMassStepCell = [UINib nibWithNibName:@"ActiveMassStepCell" bundle:nil];
    [tableView registerNib:reuseActiveActiveMassStepCell forCellReuseIdentifier:CellIdentifierActiveMassStepCell];
    
    UINib *reuseActiveMassCalorieCell = [UINib nibWithNibName:@"ActiveMassCalorieCell" bundle:nil];
    [tableView registerNib:reuseActiveMassCalorieCell forCellReuseIdentifier:CellIdentifierActiveMassCalorieCell];
    
    UINib *reuseActiveMassExerciseCell = [UINib nibWithNibName:@"ActiveMassExerciseCell" bundle:nil];
    [tableView registerNib:reuseActiveMassExerciseCell forCellReuseIdentifier:CellIdentifierActiveMassExerciseCell];
    
    if (indexPath.row == 0) {
        
        ActiveMassChartView *cell = (ActiveMassChartView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassChartViewCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassChartView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassChartViewCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else if (indexPath.row == 1) {
        
        ActiveMassStepCell *cell = (ActiveMassStepCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassStepCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassStepCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassStepCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else if (indexPath.row == 2) {
        
        ActiveMassCalorieCell *cell = (ActiveMassCalorieCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassCalorieCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassCalorieCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassCalorieCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else {
        
        ActiveMassExerciseCell *cell = (ActiveMassExerciseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassExerciseCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassExerciseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassExerciseCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
       
        return 314;
    }
    
    else if (indexPath.row == 1) {
        
        return 96;
    }
    
    else if (indexPath.row == 2) {
        
        return 96;
    }
    else {
        
        return 146;
    }
}

@end