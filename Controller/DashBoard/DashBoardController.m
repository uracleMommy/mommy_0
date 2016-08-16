//
//  DashBoardController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DashBoardController.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"

@interface DashBoardController ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate>

@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect containerFrame = _pageViewContainer.frame;
    
    OTPageView *PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 200)];
    PScrollView.pageScrollView.dataSource = self;
    PScrollView.pageScrollView.delegate = self;
    PScrollView.pageScrollView.padding =50;
    PScrollView.pageScrollView.leftRightOffset = 0;
    PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -250)/2, 60, 250, 100);
    PScrollView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    
    // 페이지뷰에 담길 커스텀 뷰
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark OTPageScrollViewDataSource CallBackMethod
- (UIView*)pageScrollView:(OTPageScrollView *)pageScrollView viewForRowAtIndex:(int)index {
    
    return nil;
}

#pragma mark OTPageScrollViewDelegate CallBackMethod
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView {
    
    return 0;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView {
    
    CGSize aa;
    
    return aa;
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index {
    
    
}


@end