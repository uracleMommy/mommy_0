//
//  SignUpMommyInfoController.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 23..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpMommyInfoController.h"

@interface SignUpMommyInfoController ()

@end

@implementation SignUpMommyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setHidesBackButton:YES];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    if(!scrollViewContoller){
        scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMommyInfoScrollView"];
        
        scrollViewContoller.delegate = self;
        
        [scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 530)];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 530);
        
        [_scrollView addSubview : scrollViewContoller.view];
        
        [_scrollView sizeToFit];
    }
}

-(void)callImageView:(UIImage*)image{
    if(_singleImageView == nil){
        _singleImageView = [[SingleImageViewController alloc] init];
    }
    
    _singleImageView.originalImage = image;
    
    [self presentViewController:_singleImageView animated:YES completion:nil];
}

-(void)callCameraView{
    if(_cameraView == nil){
        _cameraView = [[UIImagePickerController alloc] init];
        [_cameraView setSourceType:UIImagePickerControllerSourceTypeCamera];
        _cameraView.delegate = self;
    }
    
    [self presentViewController:_cameraView animated:YES completion:nil];
}

-(void)callLibraryView{
    if(_libraryView == nil){
        _libraryView = [[UIImagePickerController alloc] init];
        [_libraryView setDelegate:self];
    }
    
    [self presentViewController:_libraryView animated:YES completion:nil];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    _controller = [[ImageCropViewController alloc] initWithImage:image];
    
    _controller.delegate = self;
    _controller.blurredBackground = YES;
    
    [_cameraView dismissViewControllerAnimated:YES completion:nil];
    [_libraryView dismissViewControllerAnimated:YES completion:nil];

    [[self navigationController] pushViewController:_controller animated:YES];
}


#pragma mark cropView Delegate
-(void)ImageCropViewControllerSuccess:(UIViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    [scrollViewContoller setMommyImage:croppedImage];
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController] popViewControllerAnimated:YES];
}
-(void)ImageCropViewControllerDidCancel:(UIViewController *)controller{
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
