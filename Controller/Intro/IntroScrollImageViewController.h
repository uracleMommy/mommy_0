//
//  IntroScrollImageViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroScrollImageViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *imageContainerView;

@property (strong, nonatomic) UIImageView *firstImage;

@property (strong, nonatomic) UIImageView *secondImage;

@property (strong, nonatomic) UIImageView *thirdImage;

@property (assign) CGFloat scrollViewSize;

@property (assign) NSUInteger currentPageIndex;

- (void) moveScrollView : (UIScrollView *) scrollView;

- (void) bridgePageMoveCompleted : (NSUInteger) pageIndex;


@end
