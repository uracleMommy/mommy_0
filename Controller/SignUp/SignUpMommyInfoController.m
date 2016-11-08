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
    
    //기본 세팅
    _fileName = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    if(!_scrollViewContoller){
        _scrollViewContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMommyInfoScrollView"];
        
        _scrollViewContoller.delegate = self;
        
        [_scrollViewContoller.view setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, 530)];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 530);
        
        [_scrollView addSubview : _scrollViewContoller.view];
        
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
    [[MommyRequest sharedInstance] mommyImageUploadApiService:croppedImage success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            NSLog(@"Image Upload data : %@", data);
            NSDictionary *result = [data objectForKey:@"result"];
            _fileName = [result objectForKey:@"file_name"];
            dispatch_sync(dispatch_get_main_queue(), ^{ 
                [_scrollViewContoller setMommyImage:croppedImage];
            });
        }else{
            NSLog(@"Image Upload Fail");
        }
    } error:^(NSError *error) {
        NSLog(@"Image Upload Fail");
    }];
    
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

- (IBAction)confirmButtonAction:(id)sender {
    NSArray *allTextFields = [self findAllTextFieldsInView:_scrollView];
    Boolean validationFlag = TRUE;
    
    for(int i=0 ; i<[allTextFields count] ; i++){
        if([[(UITextField*)[allTextFields objectAtIndex:i] text] isEqualToString:@""]){
            validationFlag = FALSE;
            break;
        }
    }
    
    if(validationFlag){
        for(int i=0 ; i<_scrollViewContoller.nicknameValidationArr.count ; i++){
            if([[_scrollViewContoller.nicknameValidationArr objectAtIndex:i]isEqualToString:@"N"]){
                validationFlag = FALSE;
                break;
            }
        }
    }
    
    if(validationFlag){
        [self performSegueWithIdentifier:@"moveFetusInfoViewSegue" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"입력하신 정보를 다시 확인 부탁드립니다."
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil, nil];
        [alert show];

    }
}

-(NSArray*)findAllTextFieldsInView:(UIView*)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITextField class]])
            [textfieldarray addObject:x];
        
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
        }
    }
    return textfieldarray;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moveFetusInfoViewSegue"])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMdd"];
        NSString *baby_birth = [formatter stringFromDate:[_scrollViewContoller.dueDateTextField date]];
        
        
        SignUpFetusInfoController *vc = [segue destinationViewController];
        [vc setFile_name:_fileName];
        [vc setNickname:[_scrollViewContoller.mommyNameTextField text]];
//        [vc setAddress:[scrollViewContoller.addressTextField text]];
        [vc setAddress:[NSNumber numberWithInteger:[[_scrollViewContoller.addressCodeDic objectForKey:[_scrollViewContoller.addressTextField text]] intValue]]];
        [vc setBaby_birth:baby_birth];
        [vc setBefore_weight:[_scrollViewContoller.beforeWeightTextField text]];
        [vc setWeight:[_scrollViewContoller.nowWeightTextField text]];
        [vc setHeight:[_scrollViewContoller.heightTextField text]];
        [vc setBaby_cnt:[_scrollViewContoller.fetusCountTextField text]];
    }
}

- (IBAction)prepareForUnwind:(id)sender{
    
}

@end
