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

- (void)viewWillAppear:(BOOL)animated{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:_mentorKey forKey:@"mento_key"];
    
    [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoProfile authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data){
        NSLog(@"PSH data %@", data);
        
        NSString *code = [NSString stringWithFormat:@"%@", [data objectForKey:@"code"]];
        if([code isEqual:@"0"]){
            NSDictionary *stepInfo = [[data objectForKey:@"result"] objectForKey:@"step_info"];
            NSDictionary *mentoInfo = [[data objectForKey:@"result"] objectForKey:@"mento_info"];
            dispatch_async(dispatch_get_main_queue(), ^{
                _totalKalLabel.text = [NSString stringWithFormat:@"%@", [stepInfo objectForKey:@"total_step_kal"]];
                _avgKalLabel.text = [NSString stringWithFormat:@"%@", [stepInfo objectForKey:@"avg_step_kal"] ];
                _totalStepLabel.text = [NSString stringWithFormat:@"%@", [stepInfo objectForKey:@"total_step"]];
                _avgStepLabel.text = [NSString stringWithFormat:@"%@", [stepInfo objectForKey:@"avg_step"]];
                
                _nameLabel.text = [NSString stringWithFormat:@"%@ (%@년생)", [mentoInfo objectForKey:@"mento_nickname"], [[mentoInfo objectForKey:@"mento_birth"] substringWithRange:NSMakeRange(2, 2)]];
                _babyBirthLabel.text = [NSString stringWithFormat:@"출산예정일 %@",  [self getMommyDateyyyyMMdd:[mentoInfo objectForKey:@"baby_birth"]]];
                
                if([[mentoInfo objectForKey:@"mento_yn"] isEqualToString:@"Y"]){
                    [_mentorButton setImage:[UIImage imageNamed:@"popup_btn_icon_mentor.png"] forState:UIControlStateNormal];
                }else{
                    [_mentorButton setImage:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"] forState:UIControlStateNormal];
                }
                
                if(![[mentoInfo objectForKey:@"img"] isEqualToString:@""]){
                    
                    NSString *profileImageIdentifier = [NSString stringWithFormat:@"Cell%@", [mentoInfo objectForKey:@"img"]];
                    
                    char const * s = [profileImageIdentifier  UTF8String];
                    dispatch_queue_t queue = dispatch_queue_create(s, 0);
                    dispatch_async(queue, ^{
                        
                        NSString *imageDownUrl = [NSString stringWithFormat:@"%@?f=%@", [[MommyHttpUrls sharedInstance] requestImageDownloadUrl], [mentoInfo objectForKey:@"img"]];
                        
                        UIImage *profileImg = nil;
                        NSData *firstImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageDownUrl]];
                        profileImg = [[UIImage alloc] initWithData:firstImageData];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_profileImage setImage:profileImg];
                        });
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_profileImage setImage:[UIImage imageNamed:@"contents_profile_default_large"]];
                    });                    
                }
                
            });
        }else{
            
        }
    } error:^(NSError *error) {
        NSLog(@"PSH error %@", error);
    } ];
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

- (IBAction)moveWriteMessageView:(id)sender {
    [self.view removeFromSuperview];
    [_delegate moveWriteMessageView:_mentorKey mentoNickName:_mentorNickname];
}

- (IBAction)moveNewspeedViewAction:(id)sender{
    [self.view removeFromSuperview];
    [_delegate moveNewspeedViewAction:_mentorKey mentoNickName:_mentorNickname];
}

- (IBAction)toggleMentorAction:(id)sender {
    if([_mentorButton.imageView.image isEqual:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"]]){
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:_mentorKey forKey:@"mento_key"];
        
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [_mentorButton setImage:[UIImage imageNamed:@"popup_btn_icon_mentor.png"] forState:UIControlStateNormal];
                    if ([self.delegate respondsToSelector:@selector(changedMento:insert:)]) {
                        [_delegate changedMento:_tableIndex insert:@"Y"];
                    }
                });
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:_mentorKey forKey:@"mento_key"];
        
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoDelete authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [_mentorButton setImage:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"] forState:UIControlStateNormal];
                    if ([self.delegate respondsToSelector:@selector(changedMento:insert:)]) {
                        [_delegate changedMento:_tableIndex insert:@"N"];
                    }
                });
            }
        } error:^(NSError *error) {
            
        }];
    }
}

#pragma mark 마미앤 날짜 형식 변환기(yyyy.MM.dd)
- (NSString *) getMommyDateyyyyMMdd : (NSString *) dateFormatString {
    
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
