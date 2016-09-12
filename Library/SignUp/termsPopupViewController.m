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
    [self.view removeFromSuperview];
}
@end
