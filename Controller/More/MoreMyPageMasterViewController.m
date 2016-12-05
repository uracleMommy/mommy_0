//
//  MoreMyPageMasterViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreMyPageMasterViewController.h"

@interface MoreMyPageMasterViewController ()

@end

@implementation MoreMyPageMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationItem setHidesBackButton:YES];
    
    //back Button Setting
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"title_icon_back"];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;

    
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    
    if (mainRect.size.height <= 480) {
        
        _infoViewTopConstraint.constant = _infoViewTopConstraint.constant - 17;
        _infoViewBottomConstraint.constant = _infoViewBottomConstraint.constant - 10;
    }
    
    //_infoViewTopConstraint.constant = _infoViewTopConstraint.constant - 17;
    }

- (void) viewDidAppear:(BOOL)animated{
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"containerTableView"]) {
        
        _moreMyPageSubInfoPanelController = segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"containerBlurView"]) {
        
        _moreMyPageSubImageController = segue.destinationViewController;
    }else if([[segue identifier] isEqualToString:@"goFetusCountChangeModal"]){
        UINavigationController *navController = [segue destinationViewController];
        MoreMyPageFetusInfoChangeViewController *vc = (MoreMyPageFetusInfoChangeViewController *)([navController viewControllers][0]);
        [vc setBabyNickNames:_babyNickNames];
    }else if([[segue identifier] isEqualToString:@"goInfoChangeModal"]){
        UINavigationController *navController = [segue destinationViewController];
        MoreMyPageNickNameChangeViewController *vc = (MoreMyPageNickNameChangeViewController *)([navController viewControllers][0]);
        
        vc.type = [_selectedItem tag];
        vc.valueText = [_selectedItem text];
    }
}

#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 0 && buttonIndex == 1) { //회원탈퇴
        NSDictionary *param;
        
        [[MommyRequest sharedInstance] mommyMyPageApiService:MyPageDeleteUser authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            //TODO 성공시 브랜드 가이드 화면으로 이동
        } error:^(NSError *error) {
            
        }];
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
    [[MommyRequest sharedInstance] mommyMyPageImageUploadApiService:croppedImage authKey:GET_AUTH_TOKEN success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            NSLog(@"Image Upload data : %@", data);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_moreMyPageSubImageController setMommyImage:croppedImage];
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

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initData{
    
    [[MommyRequest sharedInstance] mommyMyPageApiService:MyPageProfile authKey:GET_AUTH_TOKEN parameters:@{} success:^(NSDictionary *data) {
        if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
            NSDictionary *result = [data objectForKey:@"result"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                _babyNickNames = [result objectForKey:@"baby_nicknames"];
                _moreMyPageSubInfoPanelController.lblEmail.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"email"]];
                _moreMyPageSubInfoPanelController.lblBabyBirth.text = [NSString stringWithFormat:@"%@", [self getyyyyMMdd:[result objectForKey:@"baby_birth"] ]];
                _moreMyPageSubInfoPanelController.lblAddress.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"address_name"]];
                _moreMyPageSubInfoPanelController.lblFetus.text = [NSString stringWithFormat:@"%@명", [result objectForKey:@"baby_cnt"]];
                _moreMyPageSubInfoPanelController.lblBeforeWeight.text = [NSString stringWithFormat:@"%@kg", [result objectForKey:@"before_weight"]];
                _moreMyPageSubInfoPanelController.lblWeight.text = [NSString stringWithFormat:@"%@kg", [result objectForKey:@"weight"]];
                _moreMyPageSubInfoPanelController.lblHeight.text = [NSString stringWithFormat:@"%@cm", [result objectForKey:@"height"]];
                _moreMyPageSubInfoPanelController.lblNickName.text = [NSString stringWithFormat:@"%@", [result objectForKey:@"nickname"]];
                
                _moreMyPageSubImageController.user_name.text = [result objectForKey:@"name"];
                _moreMyPageSubImageController.user_birth.text = [self getyyyyMMdd:[result objectForKey:@"birth"]];
                
                NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [result objectForKey:@"img"]];
                
                if([profileImageIdentifier isEqualToString:@"Cell"]){
//                    [_moreMyPageSubImageController setMommyImage:[UIImage imageNamed:@"contents_profile_default"]];
                    [_moreMyPageSubImageController.mommyImageButton setImage:[UIImage imageNamed:@"contents_profile_default"] forState:UIControlStateNormal];
                    [_moreMyPageSubImageController.mommyImageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
                }else{
                    
                    char const * s = [profileImageIdentifier  UTF8String];
                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                    dispatch_async(queue, ^{
                        
                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [result objectForKey:@"img"]];
                        
                        UIImage *profileImg = nil;
                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_moreMyPageSubImageController setMommyImage:profileImg];
                        });
                    });
                }
                
            });
        }
    } error:^(NSError *error) {
    }];
}


#pragma mark 모달 창 관련

#pragma 데이터 수정 모달
- (void) modalChangeInfo:(id)sender {
    _selectedItem = sender;
    [self performSegueWithIdentifier:@"goInfoChangeModal" sender:nil];
}

#pragma 태아 수정 모달
- (void) modalFetusChange {
    [self performSegueWithIdentifier:@"goFetusCountChangeModal" sender:nil];
}



#pragma mark footer Button
- (IBAction)closeModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteUserAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                    message:@"탈퇴 후 등록한 활동정보, 다이어리 등의 정보를 복구하실 수 없습니다.\n본 서비스에서 탈퇴하시겠습니까?"
                                                   delegate:self
                                          cancelButtonTitle:@"취소"
                                          otherButtonTitles:@"회원탈퇴", nil];
    
    alert.tag = 0;
    [alert show];
}


#pragma mark 마미앤 날짜 형식 변환기(yyyy.MM.dd)
- (NSString *) getyyyyMMdd : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *yyyymmdd = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmdd;
}

@end
