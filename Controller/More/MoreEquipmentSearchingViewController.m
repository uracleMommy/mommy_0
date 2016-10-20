//
//  MoreEquipmentSearchingViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentSearchingViewController.h"
#import "MoreEquipmentSelectViewController.h"

@interface MoreEquipmentSearchingViewController ()

@end

@implementation MoreEquipmentSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreEquipmentSearchingModel = [[MoreEquipmentSearchingModel alloc] init];
    _tableView.dataSource = _moreEquipmentSearchingModel;
    _tableView.delegate = _moreEquipmentSearchingModel;
    
    _imageContainerView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.0f];
    
    _gifImageView = [[FLAnimatedImageView alloc] init];
    _gifImageView.contentMode = UIViewContentModeScaleAspectFill;
    _gifImageView.clipsToBounds = YES;
    [_imageContainerView addSubview:_gifImageView];
    
    [_gifImageView setFrame:CGRectMake(0, 0, 100, 100)];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"loading_search" withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    _gifImageView.animatedImage = animatedImage;
    
    
    // 서치후에 검색이 되는 기기들이 있으면 다음화면으로 분기    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(moveToSelect) userInfo:nil repeats:NO];
    
    if(_deviceKind == SearchDeviceBand) {
        
        self.navigationItem.title = @"활동량계 검색";
    }
    else {
        
        self.navigationItem.title = @"체중계 검색";
    }
}

#pragma 기기선택 화면으로 이동
- (void) moveToSelect {
    
    [self performSegueWithIdentifier:@"goEquipmentSelect" sender:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goEquipmentSelect"]) {
        
        MoreEquipmentSelectViewController *moreEquipmentSelectViewController = (MoreEquipmentSelectViewController *)segue.destinationViewController;
        moreEquipmentSelectViewController.deviceKind = _deviceKind;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
