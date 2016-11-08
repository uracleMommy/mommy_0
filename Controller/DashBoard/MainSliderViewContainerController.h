//
//  MainSliderViewContainerController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWViewPager.h"

@protocol MainSliderViewContainerDelegate <NSObject>

@required
- (void)moveWeekProgram:(NSDictionary *)program;

@end

@interface MainSliderViewContainerController : UIViewController<UICollectionViewDataSource, HWViewPagerDelegate>

@property (weak, nonatomic) IBOutlet HWViewPager *mainSlider;

@property (strong, nonatomic) NSArray *programList;

@property (strong, nonatomic) id<MainSliderViewContainerDelegate> delegate;

@end
