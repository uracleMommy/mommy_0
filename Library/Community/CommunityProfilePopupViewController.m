//
//  CommunityProfilePopupViewController.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityProfilePopupViewController.h"

@interface CommunityProfilePopupViewController ()

@end

@implementation CommunityProfilePopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    CAShapeLayer *firstShapeLayer = [CAShapeLayer layer];
    [firstShapeLayer setBounds:_popupView.bounds];
    [firstShapeLayer setPosition:_popupView.center];
    [firstShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [firstShapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
    [firstShapeLayer setLineWidth:1.0f];
    [firstShapeLayer setLineJoin:kCALineJoinRound];
    [firstShapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    CGMutablePathRef firstPath = CGPathCreateMutable();
    CGPathMoveToPoint(firstPath, NULL, 0, 0);
    CGPathAddLineToPoint(firstPath, NULL, _popupView.frame.size.width - 38.0, 0);
    
    [firstShapeLayer setPath:firstPath];
    CGPathRelease(firstPath);
    
    [[_lineLabel layer] addSublayer:firstShapeLayer];
    
    _popupView.layer.cornerRadius = 20;//half of the width
    _popupView.layer.masksToBounds = YES;
    
    _todayTitleLabel.layer.cornerRadius = 10;//half of the width
    _todayTitleLabel.layer.masksToBounds = YES;
    
    _profileImage.layer.cornerRadius = 50;
    _profileImage.layer.masksToBounds = YES;

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

- (IBAction)closePopupAction:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)moveWriteMessageViewAction:(id)sender {
    [self.view removeFromSuperview];
    [_delegate moveWriteMessageViewAction:sender];
}

- (IBAction)moveNewspeedViewAction:(id)sender {
    [self.view removeFromSuperview];
    [_delegate moveNewspeedViewAction:sender];
}

- (IBAction)toggleMentorAction:(id)sender {
    if([_mentorButton.imageView.image isEqual:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"]]){
        [_mentorButton setImage:[UIImage imageNamed:@"popup_btn_icon_mentor.png"] forState:UIControlStateNormal];
    }else{
        [_mentorButton setImage:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"] forState:UIControlStateNormal];
    }
}

@end
