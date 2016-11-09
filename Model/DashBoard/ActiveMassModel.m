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
        cell.delegate = self;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:_dicList options:0 error:&error];
        NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
        NSLog(@"%@",myString);
        
        // 자바스크립트 펑션 호출
        cell.isFirst = YES;
        cell.functionJson = myString;
        cell.lblTitle.text = _dicList[@"title_tag"];
        cell.lblComment.text = [[_dicList[@"comment"] class] isEqual:[NSNull class]] ? @"" : _dicList[@"comment"];
        [cell.webView loadRequest:_chartRequest];
        
        return cell;
    }
    
    // 걸음
    else if (indexPath.row == 1) {
        
        ActiveMassStepCell *cell = (ActiveMassStepCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassStepCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassStepCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassStepCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lblStep.text = [NSString stringWithFormat:@"%ld", [_dicList[@"step"] longValue]];
        cell.lblRecStep.text = _dicList[@"rec_step"];
        
        return cell;
    }
    
    // 칼로리
    else if (indexPath.row == 2) {
        
        ActiveMassCalorieCell *cell = (ActiveMassCalorieCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassCalorieCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassCalorieCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassCalorieCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lblCal.text = [NSString stringWithFormat:@"%.01f", [_dicList[@"cal"] doubleValue]];
        cell.lblRecCal.text = _dicList[@"rec_cal"];
        
        return cell;
    }
    // 운동시간
    else {
        
        ActiveMassExerciseCell *cell = (ActiveMassExerciseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassExerciseCell];
        
        if (cell == nil) {
            
            cell = (ActiveMassExerciseCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierActiveMassExerciseCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lblExerciseTime.text = _dicList[@"exec_time"];
        
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

#pragma 차트 콜백
- (void) goPrevious {
    
    if ([self.delegate respondsToSelector:@selector(goChartPrevious)]) {
        
        [self.delegate goChartPrevious];
    }
    
}

#pragma 차트 콜백
- (void) goNext {
    
    if ([self.delegate respondsToSelector:@selector(goChartNext)]) {
        
        [self.delegate goChartNext];
    }
}

@end
