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
#import "DashBoardScrollCellView.h"

@interface DashBoardController ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate>

@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect containerFrame = _pageViewContainer.frame;
    OTPageView *PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, containerFrame.size.height)];
    PScrollView.pageScrollView.dataSource = self;
    PScrollView.pageScrollView.delegate = self;
    PScrollView.pageScrollView.padding = 10;
    PScrollView.pageScrollView.leftRightOffset = 0;
    PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -370)/2, 60, 370, 100);
    PScrollView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    
    [_pageViewContainer addSubview:PScrollView];
    
    // 페이지뷰에 담길 커스텀 뷰
    DashBoardScrollCellView *view1 = [[DashBoardScrollCellView alloc] initWithNibName:@"DashBoardScrollCellView" bundle:nil];
    [view1.view setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 60, 150)];
    DashBoardScrollCellView *view2 = [[DashBoardScrollCellView alloc] initWithNibName:@"DashBoardScrollCellView" bundle:nil];
    [view2.view setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 60, 150)];
    DashBoardScrollCellView *view3 = [[DashBoardScrollCellView alloc] initWithNibName:@"DashBoardScrollCellView" bundle:nil];
    [view3.view setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 60, 150)];
    
    _scrollViewArray = [NSArray arrayWithObjects:view1, view2, view3, nil];
    
    [PScrollView.pageScrollView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark OTPageScrollViewDataSource CallBackMethod
- (UIView*)pageScrollView:(OTPageScrollView *)pageScrollView viewForRowAtIndex:(int)index {
    
//    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
//    cell.backgroundColor = [UIColor whiteColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, cell.frame.size.width-40, cell.frame.size.height - 40)];
//    label.text = @"김경록";
//    [cell addSubview:label];
    
    UIViewController *cell = _scrollViewArray[index];
    return cell.view;
}

#pragma mark OTPageScrollViewDelegate CallBackMethod
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView {
    
    return 3;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView {
    
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width - 60, 100);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index {
    
    
}


@end