//
//  MainSliderViewContainerController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MainSliderViewContainerController.h"
#import "MainSliderCell.h"
#import "DashBoardController.h"

@interface MainSliderViewContainerController ()

@end

@implementation MainSliderViewContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MainSliderCell";
    
    UINib *reuseMainSliderCell = [UINib nibWithNibName:@"MainSliderCell" bundle:nil];
    [collectionView registerNib:reuseMainSliderCell forCellWithReuseIdentifier:cellIdentifier];
    
    MainSliderCell *cell =  (MainSliderCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (_programList != nil) {
        
        NSDictionary *dic = _programList[indexPath.row];
        
        cell.lblTitle.text = dic[@"code_name"];
        cell.lblContent.text = dic[@"title"];
        //cell.titleImage
    }
    else {
        
        cell.lblTitle.text = @"";
        cell.lblContent.text = @"";
        
        if (indexPath.row == 0) {
            
            [cell.titleImage setImage:[UIImage imageNamed:@"home_icon_card01"]];
        }
        else if (indexPath.row == 1) {
            
            [cell.titleImage setImage:[UIImage imageNamed:@"home_icon_card02"]];
        }
        else {
            
            [cell.titleImage setImage:[UIImage imageNamed:@"home_icon_card03"]];
        }
        
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}
- (void)pagerDidSelectedPage:(NSInteger)selectedPage {
    
    DashBoardController *dashBoardController = (DashBoardController *)self.parentViewController;
    [dashBoardController setMainSliderPage:selectedPage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
