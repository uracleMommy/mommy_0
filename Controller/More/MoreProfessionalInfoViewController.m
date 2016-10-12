//
//  MoreProfessionalInfoViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalInfoViewController.h"

@interface MoreProfessionalInfoViewController ()


@end

@implementation MoreProfessionalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 우측버튼
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightNegativeSpacer.width = -16;
    [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, closeButton]];
    
    [_segmentView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    
    [_segmentView setShowsCount:NO];
//
    [self getProfessionalList:1];
}

#pragma 전문가 목록 가져오기
- (void) getProfessionalList : (NSInteger) currentPage {
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [[NSDictionary alloc] init];
    
    [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalList authKey:auth_key parameters:parameters success:^(NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data == nil) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            long code = [data[@"code"] longValue];
            
            // 실패시
            if (code != 0) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
            
            _arrayList = [NSArray arrayWithArray:data[@"result"]];
            
            NSMutableArray *professionalList = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in _arrayList) {
                
                [professionalList addObject:dic[@"name"]];
                NSLog(@"%@", dic[@"name"]);
            }
            
            _segmentView.items = professionalList;
            _segmentView.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
            _segmentView.selectedSegmentIndex = 0;
            [_segmentView addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
            NSDictionary *dic = _arrayList[0];
            _txtContent.text = [NSString stringWithFormat:@"%@", dic[@"history"]];
        });
    } error:^(NSError *error){
        
        NSLog(@"%@", error);
    }];
}

- (void) selectedSegment:(id) sender {
    
    DZNSegmentedControl *control = (DZNSegmentedControl *)sender;
    NSLog(@"%ld", (long)control.selectedSegmentIndex);
    
    NSDictionary *dic = _arrayList[(long)control.selectedSegmentIndex];
    _txtContent.text = [NSString stringWithFormat:@"%@", dic[@"history"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeModal {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
