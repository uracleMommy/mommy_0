//
//  DiaryListController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListController.h"

@interface DiaryListController ()

@end

@implementation DiaryListController

- (void)viewDidLoad {
    _diaryListTableController = [[DiaryListModel alloc]init];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
    
    //add Button Setting
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addBtnImage = [UIImage imageNamed:@"title_icon_add.png"];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setImage:addBtnImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(showAddPopup) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.leftBarButtonItem = addButton;

    
    //message Button Setting
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *messageBtnImage = [UIImage imageNamed:@"title_icon_message.png"];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    [messageBtn setImage:messageBtnImage forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(moveToMessage) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
    UIBarButtonItem *messageButton = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    //alarm Button Setting
    UIButton *alarmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *alarmBtnImage = [UIImage imageNamed:@"title_icon_alarm.png"];
    alarmBtn.frame = CGRectMake(0, 0, 40, 40);
    [alarmBtn setImage:alarmBtnImage forState:UIControlStateNormal];
    [alarmBtn addTarget:self action:@selector(moveToAlarm) forControlEvents:UIControlEventTouchUpInside];
    [alarmBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *alarmButton = [[UIBarButtonItem alloc] initWithCustomView:alarmBtn];
    
    NSArray *rightBarButtonItems = [[NSArray alloc] initWithObjects: alarmButton, messageButton, nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;

    
    _diaryListTableController.delegate = self;
    
    [_listTableview setDelegate:_diaryListTableController];
    [_listTableview setDataSource:_diaryListTableController];
    _listTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listTableview reloadData];
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

- (void)showAddPopup{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
//    NSLog(@"PSH %@", self.navigationItem.leftBarButtonItem.customView);

    UIImage *addImage = [UIImage imageNamed:@"title_icon_add.png"];
    UIImage *closeImage = [UIImage imageNamed:@"title_icon_close.png"];
    
    NSData *clickImage = UIImagePNGRepresentation([imageView currentImage]);
    NSData *addImageData = UIImagePNGRepresentation(addImage);
    
    if([clickImage isEqual:addImageData]){
        [imageView setImage:closeImage forState:UIControlStateNormal];
        
        NSArray *menuItems =
        @[
          [KxMenuItem menuItem:@"다이어리"
                        target:self
                        action:@selector(moveWriteDiary:)],
          
          [KxMenuItem menuItem:@"일정"
                        target:self
                        action:@selector(moveWriteSchedule:)],
          ];
        
        KxMenuItem *first = menuItems[0];
        first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
        first.alignment = NSTextAlignmentCenter;
        
        [KxMenu showMenuInView:self.view
                      fromRect:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.x, imageView.frame.size.width, imageView.frame.size.height)
                     menuItems:menuItems];
        
        [KxMenu setTarget:self action:@selector(dismissMenu)];

    }else{
        [KxMenu dismissMenu];
        [imageView setImage:addImage forState:UIControlStateNormal];
        
    }
}

- (void)dismissMenu{
    NSLog(@"dismissMenu");
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    [imageView setImage:[UIImage imageNamed:@"title_icon_add.png"] forState:UIControlStateNormal];
}

- (void) moveWriteDiary:(id)sender{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    [imageView setImage:[UIImage imageNamed:@"title_icon_add.png"] forState:UIControlStateNormal];
    
    [self performSegueWithIdentifier:@"writeDiarySegue" sender:self];
}

- (void) moveWriteSchedule:(id)sender{
    UIButton *imageView = self.navigationItem.leftBarButtonItem.customView;
    [imageView setImage:[UIImage imageNamed:@"title_icon_add.png"] forState:UIControlStateNormal];
    
    [self performSegueWithIdentifier:@"writeDetailScheduleSegue" sender:self];
}

- (void)moveToMessage{
    NSLog(@"moveToMessage");
    
    // MessageNaivgation
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"MessageNaivgation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

- (void)moveToAlarm{
    NSLog(@"moveToAlarm");
    
    UIStoryboard *messageStoryboard = [UIStoryboard storyboardWithName:@"PushNotice" bundle:nil];
    UINavigationController *messageNavigationController = (UINavigationController *)[messageStoryboard instantiateViewControllerWithIdentifier:@"PushListNavigation"];
    
    [self presentViewController:messageNavigationController animated:YES completion:nil];
}

-(void) tableView:(UITableView *)tableView selectedIndexPath:(NSIndexPath *)indexPath{
//    [self performSegueWithIdentifier:@"showDetailScheduleSegue" sender:nil];
    [_delegate tableView:tableView selectedIndexPath:indexPath];
}

@end
