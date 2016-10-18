//
//  MoreMyPageSubImageController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreMyPageMasterViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "FXBlurView.h"

@interface MoreMyPageSubImageController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *mommyImageButton;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_birth;
@property (strong, nonatomic) UIImage *defaultImage;

-(void)setMommyImage:(UIImage *)croppedImage;
-(IBAction)mommyPictureButtonAction:(id)sender;

@end
