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

-(void)callCameraView{
    if(cameraView == nil){
        cameraView = [[UIImagePickerController alloc] init];
        [cameraView setSourceType:UIImagePickerControllerSourceTypeCamera];
        cameraView.delegate = self;
    }
    
    [self presentViewController:cameraView animated:YES completion:nil];
}

-(void)callLibraryView{
    if(libraryView == nil){
        libraryView = [[UIImagePickerController alloc] init];
        [libraryView setDelegate:self];
    }
    
    [self presentViewController:libraryView animated:YES completion:nil];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    controller = [[ImageCropViewController alloc] initWithImage:image];
    
    controller.delegate = self;
    controller.blurredBackground = YES;
    
    [cameraView dismissViewControllerAnimated:YES completion:nil];
    [libraryView dismissViewControllerAnimated:YES completion:nil];

    [[self navigationController] pushViewController:controller animated:YES];
}


#pragma mark cropView Delegate
-(void)ImageCropViewControllerSuccess:(UIViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    [scrollViewContoller setMommyImage:croppedImage];
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController] popViewControllerAnimated:YES];
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
