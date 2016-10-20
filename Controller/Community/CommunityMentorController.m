//
//  CommunityMentorController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 27..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityMentorController.h"

@interface CommunityMentorController ()

@end

@implementation CommunityMentorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableListController = [[CommunityPersonListModel alloc] init];
    _tableListController.addMentorButtonFlag = NO;
    _tableListController.delegate = self;
    _tableView.delegate = _tableListController;
    _tableView.dataSource = _tableListController;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [self showIndicator];
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoList authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSArray *result = [data objectForKey:@"result"];
            
            if([result count] == 0){
                if(!_noDataController){
                    _noDataController = [self.storyboard instantiateViewControllerWithIdentifier:@"noDataMentorController"];
                    [_noDataController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                    _noDataController.view.tag = 2;
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.view addSubview : _noDataController.view];
                    _tableView.hidden = YES;
                });
            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    _tableView.hidden = NO;
                    if(self.view.subviews[0].tag == 2){
                        [self.view.subviews[0] removeFromSuperview];
                    }
                });
                [_tableListController.personList removeAllObjects];
                [_tableListController.personList addObjectsFromArray:result];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
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

-(void)tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
    [_delegate moveCommunityList:[(CommunityPersonListCustomCell *)[tableView cellForRowAtIndexPath:indexPath] mentorKey] value:nil title:[(CommunityPersonListCustomCell *)[tableView cellForRowAtIndexPath:indexPath] mentorNicknameLabel].text];
}

@end
