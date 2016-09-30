//
//  IntroScrollImageViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 29..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroScrollImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIView *imageContainerView;

@property (strong, nonatomic) UIImageView *firstImage;

@property (strong, nonatomic) UIImageView *secondImage;

@property (strong, nonatomic) UIImageView *thirdImage;

@end
