//
//  SingleImageViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 26..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage *originalImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

- (IBAction)btnCloseAction:(id)sender;

@end