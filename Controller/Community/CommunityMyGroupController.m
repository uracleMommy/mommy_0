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
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    _groupKeyArr = [[NSMutableArray alloc] init];
    _groupValueArr = [[NSMutableArray alloc] init];
    
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
                    [_groupKeyArr addObject:[groupDic objectForKey:@"group_key"]];
                    [_groupValueArr addObject:[groupDic objectForKey:@"group_value"
                                               ]];
                    if(i == 0){
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            _groupNameLabel01.text = [groupDic objectForKey:@"group_name"];
                            _groupButton01.tag = [_groupKeyArr count]-1;
//                            [_groupButton01 setTitle:[groupDic objectForKey:@"group_key"] forState:UIControlStateNormal];
                        });
                    }else if(i == 1){
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            _groupNameLabel02.text = [groupDic objectForKey:@"group_name"];
                            _groupButton02.tag = [_groupKeyArr count]-1;
//                            [_groupButton02 setTitle:[groupDic objectForKey:@"group_key"] forState:UIControlStateNormal];
                        });
                    }else if(i == 2){
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            _groupNameLabel03.text = [groupDic objectForKey:@"group_name"];
                            _groupButton03.tag = [_groupKeyArr count]-1;
//                            [_groupButton03 setTitle:[groupDic objectForKey:@"group_key"] forState:UIControlStateNormal];
                        });
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
    [_delegate moveCommunityList:[_groupKeyArr objectAtIndex:[sender tag]] value:[_groupValueArr objectAtIndex:[sender tag]]];
}
@end
