//
//  MoreBloodPressureModel.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureModel.h"
#import "MoreBloodPressureHistoryCell.h"
#import "MoreBloodPressureInfoCell.h"
#import "MoreBloodPressureInfoView.h"
#import "MoreBloodPressureFooterCell.h"
#import "MoreBloodPressureDeleteButtonController.h"
#import "MommyUtils.h"

@implementation MoreBloodPressureModel

- (id) init {
    
    if (self = [super init]) {
        _arrayList = [[NSMutableArray alloc] init];
        _buttonArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_arrayList.count > 0) {
        
        // 차트셀 + 인포셀 헤더 풋터
        return _arrayList.count + 3;
    }
    else {
        
        // 차트 셀 한개는 리턴이 되어야 함
        return 1;
    }
}

#pragma 셀 버전
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierMoreBloodPressureChartCell = @"MoreBloodPressureChartCell";
    static NSString *CellIdentifierMoreBloodPressureHistoryCell = @"MoreBloodPressureHistoryCell";
    static NSString *CellIdentifierMoreBloodPressureInfoCell = @"MoreBloodPressureInfoCell";
    static NSString *CellIdentifierMoreBloodPressureFooterCell = @"MoreBloodPressureFooterCell";
    
    UINib *reuseMoreBloodPressureChartCell = [UINib nibWithNibName:@"MoreBloodPressureChartCell" bundle:nil];
    [tableView registerNib:reuseMoreBloodPressureChartCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureChartCell];
    
    UINib *reuseMoreBloodPressureHistoryCell = [UINib nibWithNibName:@"MoreBloodPressureHistoryCell" bundle:nil];
    [tableView registerNib:reuseMoreBloodPressureHistoryCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
    
    UINib *reuseMoreBloodPressureInfoCell = [UINib nibWithNibName:@"MoreBloodPressureInfoCell" bundle:nil];
    [tableView registerNib:reuseMoreBloodPressureInfoCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureInfoCell];
    
    UINib *reuseMoreBloodPressureFooterCell = [UINib nibWithNibName:@"MoreBloodPressureFooterCell" bundle:nil];
    [tableView registerNib:reuseMoreBloodPressureFooterCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureFooterCell];
    
    
    if (_arrayList.count > 0) {
        
        if (indexPath.row == 0) {
            
            MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
            
            if (cell == nil) {
                
                cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.delegate = self;
            
            NSError *error;
            NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:_dicList options:0 error:&error];
            NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",myString);
            
            // 자바스크립트 펑션 호출
            cell.isFirst = YES;
            cell.functionJson = myString;
            [cell.webView loadRequest:_chartRequest];
            
            return cell;
        }
        else if (indexPath.row == 1) {
            
            MoreBloodPressureHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
            
            if (cell == nil) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else if (indexPath.row == _arrayList.count + 2) {
            
            MoreBloodPressureFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureFooterCell];
            
            if (cell == nil) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureFooterCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        // 데이터 부분
        else {
            
            MoreBloodPressureInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureInfoCell];
            
            if (cell == nil) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureInfoCell];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            MoreBloodPressureDeleteButtonController *moreBloodPressureDeleteButtonController = [[MoreBloodPressureDeleteButtonController alloc] initWithNibName:@"MoreBloodPressureDeleteButtonController" bundle:nil];
            [moreBloodPressureDeleteButtonController.view setFrame:CGRectMake(0, 0, 70, 70)];
            
            cell.editingAccessoryView = moreBloodPressureDeleteButtonController.view;
            
            NSDictionary *dic = _arrayList[indexPath.row - 2];
            cell.lblWriteTime.text = [[MommyUtils sharedGlobalData] getMommyDate:dic[@"reg_dttm"]];
            cell.lblBlooodPressure.text = [NSString stringWithFormat:@"%@ / %@", dic[@"systolic"], dic[@"diastolic"]];
            NSNumber *pulse = dic[@"pulse"];
            cell.lblPurse.text = [NSString stringWithFormat:@"%ld", (long)[pulse integerValue]];
            cell.lblComment.text = dic[@"result"];
            if(![dic[@"result"] isEqual:[NSNull null]] && [dic[@"result"] isEqualToString:@"높음"]){
                cell.lblComment.textColor = [[UIColor alloc]initWithRed:249.0f/255.0f green:105.0f/255.0f blue:78.0f/255.0f alpha:1.0];
            }else if(![dic[@"result"] isEqual:[NSNull null]] && [dic[@"result"] isEqualToString:@"매우 높음"]){
                cell.lblComment.textColor = [[UIColor alloc]initWithRed:237.0f/255.0f green:28.0f/255.0f blue:36.0f/255.0f alpha:1.0];
            }else{
                cell.lblComment.textColor = [[UIColor alloc] initWithRed:0.0f green:0.0f blue:0.0f alpha:1.0];
            }
            
            return cell;
        }
    }
    else {
        
        MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
        
        if (cell == nil) {
            
            cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma 뷰 버전

//- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifierMoreBloodPressureChartCell = @"MoreBloodPressureChartCell";
//    static NSString *CellIdentifierMoreBloodPressureHistoryCell = @"MoreBloodPressureHistoryCell";
//    
//    UINib *reuseMoreBloodPressureChartCell = [UINib nibWithNibName:@"MoreBloodPressureChartCell" bundle:nil];
//    [tableView registerNib:reuseMoreBloodPressureChartCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureChartCell];
//    
//    UINib *reuseMoreBloodPressureHistoryCell = [UINib nibWithNibName:@"MoreBloodPressureHistoryCell" bundle:nil];;
//    [tableView registerNib:reuseMoreBloodPressureHistoryCell forCellReuseIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
//    
//    if (_arrayList.count > 0) {
//        
//        if (indexPath.row == 0) {
//            
//            MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
//            
//            if (cell == nil) {
//                
//                cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
//            }
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            return cell;
//        }
//        else {
//            
//            MoreBloodPressureHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
//            
//            if (cell == nil) {
//                
//                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureHistoryCell];
//            }
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            for (int i = 0; i < _arrayList.count; i++) {
//                
//                float viewYPosition = i * 70;
//                MoreBloodPressureInfoView *moreBloodPressureInfoView = [[MoreBloodPressureInfoView alloc] initWithNibName:@"MoreBloodPressureInfoView" bundle:nil];
//                
//                // 컨테이너뷰 사이즈 조절
//                [cell.containerView setFrame:CGRectMake(8, 45, tableView.frame.size.width - 16, 124 + (70.0f * i))];
//                
//                // 인포뷰에 애드
//                
//                [moreBloodPressureInfoView.view setFrame:CGRectMake(0, viewYPosition, cell.infoViewContainer.frame.size.width, 70.0f)];
//                [cell.infoViewContainer addSubview:moreBloodPressureInfoView.view];
//                
//                [_buttonArray addObject:moreBloodPressureInfoView];
//                
//                //NSLog(@"%f", moreBloodPressureInfoView.view.frame.size.width);
//            }
//            
//            return cell;
//        }
//    }
//    else {
//        
//        MoreBloodPressureChartCell *cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
//        
//        
//        if (cell == nil) {
//            
//            cell = (MoreBloodPressureChartCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifierMoreBloodPressureChartCell];
//        }
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }
//}

#pragma 셀 버전
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 데이터가 있을 때(전체 리턴)
    if (_arrayList.count > 0) {
        
        // 차트 높이
        if (indexPath.row == 0) {
            
            return 263.0f;
        }
        else if(indexPath.row == 1) {
            
            return 40.0f;
        }
        else if (indexPath.row == _arrayList.count + 2) {
            return 15.0f;
        }
        else {
            return 70.0f;
        }
    }
    // 데이터가 없을 때(차트만 리턴)
    else {
        
        return 263.0f;
    }
}

#pragma 뷰 버전
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // 데이터가 있을 때(전체 리턴)
//    if (_arrayList.count > 0) {
//        
//        // 차트 높이
//        if (indexPath.row == 0) {
//            
//            return 263.0f;
//        }
//        else {
//            
//            return 124.0f + (_arrayList.count - 1) * 70.0f;
//        }
//    }
//    // 데이터가 없을 때(차트만 리턴)
//    else {
//        
//        return 263.0f;
//    }
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        
//        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
//    }
    
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath   {
    if(indexPath.row != 0 && indexPath.row != 1 ){
        
        return YES;
    }else{
        return NO;
    }
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Clona" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        //insert your editAction here
//    }];
//    editAction.backgroundColor = [UIColor blueColor];
//    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@""  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        //insert your deleteAction here
    }];
    
//    deleteAction.
    deleteAction.backgroundColor = [UIColor whiteColor];
//       deleteAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"contents_list_delete"]];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Perform the real delete action here. Note: you may need to check editing style
    //   if you do not perform delete only.
    NSLog(@"Deleted row.");
    
    if ([self.delegate respondsToSelector:@selector(tableView:deleteIndex:)]) {
        
        [self.delegate tableView:tableView deleteIndex:indexPath.row];
    }
}

- (void) previousAction {
    
    if ([self.delegate respondsToSelector:@selector(goChartPrevious)]) {
        
        [self.delegate goChartPrevious];
    }
}

- (void) nextAction {
    
    if ([self.delegate respondsToSelector:@selector(goChartNext)]) {
        
        [self.delegate goChartNext];
    }
}

@end
