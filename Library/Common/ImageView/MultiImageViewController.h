//
//  MultiImageViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiImageViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *imgArray;
@property (assign, nonatomic) int index;

@end