//
//  MoreProfessionalDetailViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 20..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreProfessionalDetailViewController.h"
#import "MoreProfessionalAdviceViewController.h"

@interface MoreProfessionalDetailViewController ()

@end

@implementation MoreProfessionalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _afterCUDYN = @"N";
    
    if (_professionalButtonKind == ProfessionalButtonExecersize) {
        
        self.navigationItem.title = @"상담내용(운동)";
    }
    else {
        self.navigationItem.title = @"상담내용(영양)";
    }
    
    // 좌측버튼
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:addBtnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(closeModal) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftNegativeSpacer.width = -16;
    [self.navigationItem setLeftBarButtonItems:@[leftNegativeSpacer, addButton]];
    
    if (![_replyYN isEqualToString:@"Y"]) {
        
        // 우측버튼(업데이트)
        _btnQuestionUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *updateBtnImage = [UIImage imageNamed:@"title_icon_edit.png"];
        _btnQuestionUpdate.frame = CGRectMake(0, 0, 40, 40);
        [_btnQuestionUpdate setImage:updateBtnImage forState:UIControlStateNormal];
        [_btnQuestionUpdate addTarget:self action:@selector(goQuestionUpdate) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithCustomView:_btnQuestionUpdate];
        UIBarButtonItem *rightNegativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        // 우측버튼(삭제)
        _btnQuestionDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *deleteBtnImage = [UIImage imageNamed:@"title_icon_delete.png"];
        _btnQuestionDelete.frame = CGRectMake(0, 0, 40, 40);
        [_btnQuestionDelete setImage:deleteBtnImage forState:UIControlStateNormal];
        [_btnQuestionDelete addTarget:self action:@selector(goQuestionDelete) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithCustomView:_btnQuestionDelete];
        rightNegativeSpacer.width = -16;
        
        [self.navigationItem setRightBarButtonItems:@[rightNegativeSpacer, deleteButton, updateButton]];
    }
    
    [_segmentView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    
    if ([_replyYN isEqualToString:@"Y"]) {
        
        _segmentView.items = @[@"상담내용", @"답변내용"];
    }
    else {
        
        _segmentView.items = @[@"상담내용"];
    }
    
    _segmentView.tintColor = [UIColor colorWithRed:132.0f/255.0f green:68.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    _segmentView.selectedSegmentIndex = 0;
    
    [_segmentView setShowsCount:NO];        
    
    [_segmentView addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    
    [self bindQuestionReplyInfo];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([_afterCUDYN isEqualToString:@"Y"]) {
        
        [self bindQuestionReplyInfo];
        
        // 리스트 재조회
        NSArray *viewList = self.navigationController.viewControllers;
        MoreProfessionalAdviceViewController *moreProfessionalAdviceViewController = viewList[viewList.count - 2];
        moreProfessionalAdviceViewController.afterCUDYN = @"Y";
        _afterCUDYN = @"N";
    }
}

#pragma 질문/답변 정보 바인드
- (void) bindQuestionReplyInfo {
    
    [self showIndicator];
    
    NSString *auth_key = [GlobalData sharedGlobalData].authToken;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_qnaKey, @"qna_key", nil];
    
    [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalAdviceDetail authKey:auth_key parameters:parameters success:^(NSDictionary *data){
        
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
            
            _adviceInfo = data[@"result"];
            [self performSegueWithIdentifier:@"goAdviceContent" sender:_adviceInfo];
            
            [self hideIndicator];
        });
        
    } error:^(NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideIndicator];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:confirmAlertAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    }];
}



- (void) closeModal {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) selectedSegment:(id) sender {
    
    DZNSegmentedControl *control = (DZNSegmentedControl *)sender;
    
    if(control.selectedSegmentIndex == 0) {
        
        [_moreProfessionalAdviceReplyViewController.view removeFromSuperview];
        [self performSegueWithIdentifier:@"goAdviceContent" sender:_adviceInfo];
        
    }
    else {
        // 제거
        [_detailContentViewController.view removeFromSuperview];
        [self performSegueWithIdentifier:@"goReplyContent" sender:_adviceInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"goAdviceContent"]) {
        
        NSDictionary *dic = sender;
        MoreProfessionalAdviceContentsViewController *moreProfessionalAdviceContentsViewController = (MoreProfessionalAdviceContentsViewController *)segue.destinationViewController;
        moreProfessionalAdviceContentsViewController.adviceInfo = dic;
    }
    else if([segue.identifier isEqualToString:@"goReplyContent"])  {
        
        NSDictionary *dic = sender;
        MoreProfessionalAdviceReplyViewController *moreProfessionalAdviceReplyViewController = (MoreProfessionalAdviceReplyViewController *)segue.destinationViewController;
        moreProfessionalAdviceReplyViewController.replyInfo = dic;
    }
    else if([segue.identifier isEqualToString:@"goProfessionalQuestionUpdate"])  {
        
        MoreProfessionalWriteAdviceController *moreProfessionalWriteAdviceController = (MoreProfessionalWriteAdviceController *)segue.destinationViewController;
        moreProfessionalWriteAdviceController.qnaKey = _qnaKey;
        moreProfessionalWriteAdviceController.professionalQuestionWriteUpdateMode = ProfessionalQuestionUpdateMode;
    }
}

#pragma 문의 콜백 함수
- (void) imageArray:(NSArray *)imageArray startIndex:(NSInteger)startIndex {
    
    _multiImageViewController = [[MultiImageViewController alloc] initWithNibName:@"MultiImageViewController" bundle:nil];
    _multiImageViewController.imgArray = [NSArray arrayWithArray:imageArray];
    _multiImageViewController.index = (int)startIndex;
    
    [self presentViewController:_multiImageViewController animated:YES completion:nil];
}

#pragma 질문글 편집
- (void) goQuestionUpdate {
    
    // 편집처리(분기)
    [self performSegueWithIdentifier:@"goProfessionalQuestionUpdate" sender:nil];
    
}

#pragma 질문글 삭제
- (void) goQuestionDelete {
    
    // 알럿 처리
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"등록된 질문을 삭제 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"예" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self showIndicator];
        NSString *auth_key = [GlobalData sharedGlobalData].authToken;
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_qnaKey, @"qna_key", nil];
        
        [[MommyRequest sharedInstance] mommyProfessionalAdviceApiService:ProfessionalAdviceContentDelete authKey:auth_key parameters:parameters success:^(NSDictionary *data){
            
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
                
                [self hideIndicator];
                
                NSArray *viewList = self.navigationController.viewControllers;
                MoreProfessionalAdviceViewController *moreProfessionalAdviceViewController = viewList[viewList.count - 2];
                moreProfessionalAdviceViewController.afterCUDYN = @"Y";
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } error:^(NSError *error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self hideIndicator];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"잠시후 다시 시도해 주세요." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAlertAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:confirmAlertAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }];
        
    }];
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"아니오" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:confirmAlertAction];
    [alert addAction:cancelAlertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
