//
//  MoreMyPageFetusInfoChangeViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageFetusInfoChangeViewController.h"

@interface MoreMyPageFetusInfoChangeViewController ()

@end

@implementation MoreMyPageFetusInfoChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreMyPageFetusChangeModel = [[MoreMyPageFetusChangeModel alloc] init];
//    _moreMyPageFetusChangeModel.arrayList = [NSArray arrayWithObjects:@"1", @"2", nil];
    _moreMyPageFetusChangeModel.arrayList = [[NSMutableArray alloc] initWithArray:_babyNickNames];
    _moreMyPageFetusChangeModel.delegate = self;
    _tableView.dataSource = _moreMyPageFetusChangeModel;
    _tableView.delegate = _moreMyPageFetusChangeModel;
    
    /** Navigation Setting **/
    //close Button
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *closeBtnImage = [UIImage imageNamed:@"title_icon_close.png"];
    closeBtn.frame = CGRectMake(0, 0, 40, 40);
    [closeBtn setImage:closeBtnImage forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeModal:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    //save Button
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveBtnImage = [UIImage imageNamed:@"title_icon_save.png"];
    saveBtn.frame = CGRectMake(0, 0, 40, 40);
    [saveBtn setImage:saveBtnImage forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(editFetusNickname) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.leftBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}


-(void)editFetusNickname{
    NSArray *tableTextFieldArr = [self findAllTextFieldsInView:_tableView];
    NSMutableArray *fetusInfoArr = [[NSMutableArray alloc] init];
//    NSString *babyCount;
    for(int i = 0 ; i < [tableTextFieldArr count] ; i++){
        NSString *text = [(UITextField *)[tableTextFieldArr objectAtIndex:i] text];
        if([(UITextField *)[tableTextFieldArr objectAtIndex:i] tag] == 1){
//            babyCount = [text substringWithRange:NSMakeRange(0, 1)];
            break;
        }
        NSLog(@"%@", text);
        if(![text isEqualToString:@""]){
            [fetusInfoArr addObject:@{@"baby_nickname":text}];
        }
    }
    
    
    if([fetusInfoArr count] == 0){
        [fetusInfoArr addObject:@{@"baby_nickname":@""}];
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setValue:fetusInfoArr forKey:@"baby_nicknames"];
//    [param setValue:babyCount forKey:@"baby_cnt"];
    
    NSLog(@"param : %@", param);

    [[MommyRequest sharedInstance] mommyMyPageApiService:MyPageUpdateProfile authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self closeModal:nil];
            });
        }else{
            //TODO 등록 실패시..
        }

    } error:^(NSError *error) {
        
    }];
}

-(void)deleteBabyNicknameButton:(id)sender{
    NSIndexPath *indexPath = [_tableView indexPathForCell:sender];
    
    [[_moreMyPageFetusChangeModel arrayList] removeObjectAtIndex:indexPath.row-1];
    
    [_tableView beginUpdates];
    
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    [_tableView endUpdates];
    [_tableView reloadData];
}

-(void)changeCell:(NSInteger)count{
    int end = 0;
    Boolean add = TRUE;
    if(_moreMyPageFetusChangeModel.arrayList.count == count){
        return ;
    }else if([_moreMyPageFetusChangeModel.arrayList count] > count){
        end = _moreMyPageFetusChangeModel.arrayList.count  - count;
        add = FALSE;
    }else{
        end = count - _moreMyPageFetusChangeModel.arrayList.count;
    }
    
    for(int i=0 ; i<end ; i++){
        if(add){
            [_moreMyPageFetusChangeModel.arrayList addObject:@{@"baby_nickname":@""}];
        }else{
            [_moreMyPageFetusChangeModel.arrayList removeLastObject];
        }
    }
    
    [_tableView reloadData];
}

- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
