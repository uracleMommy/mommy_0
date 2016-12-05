//
//  termsPopupViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "termsPopupViewController.h"

@interface termsPopupViewController ()

@end

@implementation termsPopupViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _button_0.titleLabel.font = [UIFont fontWithName:@"NanumBarunGothicBold" size:16];
    
    // List all fonts on iPhone
//    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames = [[NSArray alloc] initWithArray:
//                     [UIFont fontNamesForFamilyName:
//                      [familyNames objectAtIndex:indFamily]]];
//        for (indFont=0; indFont<[fontNames count]; ++indFont)
//        {
//            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
//        }
////        [fontNames release];
//    }
//    [familyNames release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okButtonAction:(id)sender {
    [self.view removeFromSuperview];
    [delegate okButtonAction];
}
- (IBAction)cancleButtonAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                    message:@"서비스 및 개인정보 이용약관 미 동의 시 본 서비스를 이용하실 수 없습니다.\n 어플리케이션을 종료하시겠습니까?"                                   delegate:self                           cancelButtonTitle:@"취소"                              otherButtonTitles:@"종료", nil];
    [alert show];
}

- (IBAction)termsButtonAction:(id)sender {
    switch ((int)[sender tag]) {
        case 0:
            _type = AuthText1;
            break;
        case 1:
            _type = AuthText2;
            break;
        case 2:
            _type = AuthText3;
            break;
        default:
            break;
    }
    [self.view removeFromSuperview];
    [delegate moveTermsView:_type];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){ //"종료" pressed
        exit(0);
    }
}

@end
