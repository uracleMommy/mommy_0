//
//  WeekProgramController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "WeekProgramController.h"
#import "WeekProgramDetailController.h"

@interface WeekProgramController ()

@end

@implementation WeekProgramController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *items = @[@"건강", @"운동", @"영양"];
    
    _segment.items = items;
    
    // 132 68 240
    _segment.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _segment.delegate = self;
    _segment.selectedSegmentIndex = 0;
    [_segment setShowsCount:NO];
    [_segment addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    [_segment setFrame:CGRectMake(0, 0, screenSize.size.width, 44)];
    
    _weekProgramModel = [[WeekProgramModel alloc] init];
    _weekProgramModel.delegate = self;
    
    if (_weekProgramEnabledKind == WeekProgramEnabledHealth) {
        [_segment setSelectedSegmentIndex:0];
        [self programHealthList:1];
    }
    else if (_weekProgramEnabledKind == WeekProgramEnabledSport) {
        
        [_segment setSelectedSegmentIndex:1];
        [self programSportsList:1];
    }
    else {
        
        [_segment setSelectedSegmentIndex:2];
        [self programNutritionList:1];
    }
    
    
    // 11 건강 12 운동 13 영양
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
}

- (void) goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) didChangeSegment : (id) sender {
    
    _weekProgramModel = [[WeekProgramModel alloc] init];
    _weekProgramModel.delegate = self;
    
    // 건강
    if (_segment.selectedSegmentIndex == 0) {
        
        _weekProgramEnabledKind = WeekProgramEnabledHealth;
        [self programHealthList:1];
    }
    // 운동
    else if (_segment.selectedSegmentIndex == 1) {
        
        _weekProgramEnabledKind = WeekProgramEnabledSport;
        [self programSportsList:1];
    }
    // 영양
    else {
        
        _weekProgramEnabledKind = WeekProgramEnabledNutrition;
        [self programNutritionList:1];
    }
}

#pragma 건강 프로그램 리스트
- (void) programHealthList : (NSInteger) currentPage {
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", @"11", @"program_type", _weightStatusCode, @"weight_code", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyWeekProgramApiService:WeekProgramHealthList authKey:authToken parameters:parameters success:^(NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            }
            
            NSArray *resultArray = [NSArray arrayWithArray:data[@"result"]];
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray){
                
                NSString *context = dic[@"context"];
                NSString *html = dic[@"html"];
                NSString *img = dic[@"img"];
                NSString *program_seq = dic[@"program_seq"];
                NSString *program_title = dic[@"program_title"];
                NSString *program_type = dic[@"program_type"];
                NSString *program_type_name = dic[@"program_type_name"];
                NSString *reg_dttm = dic[@"reg_dttm"];
                NSString *week = [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:context, @"context", html, @"html", img, @"img", program_seq, @"program_seq", program_title, @"program_title", program_type, @"program_type", program_type_name, @"program_type_name", reg_dttm, @"reg_dttm", week, @"week", nil];
                [_weekProgramModel.arrayList addObject:newDic];
            }
            
            _tableView.delegate = _weekProgramModel;
            _tableView.dataSource = _weekProgramModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 운동 프로그램 리스트
- (void) programSportsList : (NSInteger) currentPage {
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", @"12", @"program_type", _weightStatusCode, @"weight_code", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyWeekProgramApiService:WeekProgramHealthList authKey:authToken parameters:parameters success:^(NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            }
            
            NSArray *resultArray = [NSArray arrayWithArray:data[@"result"]];
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray){
                
                NSString *context = dic[@"context"];
                NSString *html = dic[@"html"];
                NSString *img = dic[@"img"];
                NSString *program_seq = dic[@"program_seq"];
                NSString *program_title = dic[@"program_title"];
                NSString *program_type = dic[@"program_type"];
                NSString *program_type_name = dic[@"program_type_name"];
                NSString *reg_dttm = dic[@"reg_dttm"];
                NSString *week = [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:context, @"context", html, @"html", img, @"img", program_seq, @"program_seq", program_title, @"program_title", program_type, @"program_type", program_type_name, @"program_type_name", reg_dttm, @"reg_dttm", week, @"week", nil];
                [_weekProgramModel.arrayList addObject:newDic];
            }
            
            _tableView.delegate = _weekProgramModel;
            _tableView.dataSource = _weekProgramModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 영양 프로그램 리스트
- (void) programNutritionList : (NSInteger) currentPage {
    
    NSString *authToken = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"pageSize", [NSString stringWithFormat:@"%ld", (long)currentPage], @"searchPage", @"13", @"program_type", _weightStatusCode, @"weight_code", nil];
    
    [self showIndicator];
    
    [[MommyRequest sharedInstance] mommyWeekProgramApiService:WeekProgramHealthList authKey:authToken parameters:parameters success:^(NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                [self hideIndicator];
                return;
            }
            
            NSArray *resultArray = [NSArray arrayWithArray:data[@"result"]];
            
            // 데이터 형식 만들기
            for (NSDictionary *dic in resultArray){
                
                NSString *context = dic[@"context"];
                NSString *html = dic[@"html"];
                NSString *img = dic[@"img"];
                NSString *program_seq = dic[@"program_seq"];
                NSString *program_title = dic[@"program_title"];
                NSString *program_type = dic[@"program_type"];
                NSString *program_type_name = dic[@"program_type_name"];
                NSString *reg_dttm = dic[@"reg_dttm"];
                NSString *week = [NSString stringWithFormat:@"%ld주차", [dic[@"week"] longValue]];
                
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:context, @"context", html, @"html", img, @"img", program_seq, @"program_seq", program_title, @"program_title", program_type, @"program_type", program_type_name, @"program_type_name", reg_dttm, @"reg_dttm", week, @"week", nil];
                [_weekProgramModel.arrayList addObject:newDic];
            }

            _tableView.delegate = _weekProgramModel;
            _tableView.dataSource = _weekProgramModel;
            [_tableView reloadData];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}

#pragma 더보기 콜백
- (void) tableView:(UITableView *)tableView totalPageCount:(NSInteger) count {
    
    // 활성화 되어있는 탭에 따라서 더보기
    if (_segment.selectedSegmentIndex == 0) {
        
        [self programHealthList:count];
    }
    // 운동
    else if (_segment.selectedSegmentIndex == 1) {
        
        [self programSportsList:count];
    }
    // 영양
    else {
        
        [self programNutritionList:count];
    }
}

- (void) tableView : (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = _weekProgramModel.arrayList[indexPath.row];
    
    [self performSegueWithIdentifier:@"weekProgramDetailSegue" sender:dic[@"html"]];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"weekProgramDetailSegue"]) {
        
        WeekProgramDetailController *weekProgramDetailController = (WeekProgramDetailController *)segue.destinationViewController;
        weekProgramDetailController.htmlUrl = sender;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
