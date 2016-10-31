//
//  CommunityMyGroupController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityMyGroupController.h"

@interface CommunityMyGroupController ()

@end

@implementation CommunityMyGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _groupKeyArr = [[NSMutableArray alloc] init];
    _groupValueArr = [[NSMutableArray alloc] init];
    _groupTitleArr = [[NSMutableArray alloc] init];
    
}

- (void) viewDidAppear:(BOOL)animated{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityGroupList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            
            if([result count] == 0){
                
            }else{
                for(int i = 0 ; i < [result count] ; i++){
                    NSDictionary *groupDic = [result objectAtIndex:i];
                    if(![[groupDic objectForKey:@"group_key"] isEqual:[NSNull null]]){
                        [_groupKeyArr addObject:[groupDic objectForKey:@"group_key"]];
                        
                        if(![[groupDic objectForKey:@"group_value"] isEqual:[NSNull null]]){
                            [_groupValueArr addObject:[groupDic objectForKey:@"group_value"
                                                       ]];
                            
                            if(![[groupDic objectForKey:@"group_name"] isEqual:[NSNull null]]){
                                [_groupTitleArr addObject:[groupDic objectForKey:@"group_name"
                                                           ]];
                            }else{
                                [_groupTitleArr addObject:@""];
                            }
                            
                            
                            if(i == 0){
                                dispatch_sync(dispatch_get_main_queue(), ^{
                                    _groupNameLabel01.text = [_groupTitleArr objectAtIndex:i];
                                    _groupButton01.tag = [_groupKeyArr count]-1;
                                    //                            [_groupButton01 setTitle:[groupDic objectForKey:@"group_key"] forState:UIControlStateNormal];
                                });
                            }else if(i == 1){
                                dispatch_sync(dispatch_get_main_queue(), ^{
                                    _groupNameLabel02.text = [_groupTitleArr objectAtIndex:i];
                                    _groupButton02.tag = [_groupKeyArr count]-1;
                                    //                            [_groupButton02 setTitle:[groupDic objectForKey:@"group_key"] forState:UIControlStateNormal];
                                });
                            }else if(i == 2){
                                dispatch_sync(dispatch_get_main_queue(), ^{
                                    _groupNameLabel03.text = [_groupTitleArr objectAtIndex:i];
                                    _groupButton03.tag = [_groupKeyArr count]-1;
                                    //                            [_groupButton03 setTitle:[groupDic objectForKey:@"group_key"] forState:UIControlStateNormal];
                                });
                            }
                        }
                    }
                }
            }
            
        }else{
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{[self hideIndicator];});
    } ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)moveCommunityList:(id)sender {
    [_delegate moveCommunityList:[_groupKeyArr objectAtIndex:[sender tag]] value:[_groupValueArr objectAtIndex:[sender tag]] title:[_groupTitleArr objectAtIndex:[sender tag]]];
}
@end
