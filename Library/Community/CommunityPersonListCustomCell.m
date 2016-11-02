//
//  CommunityPersonListCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommunityPersonListCustomCell.h"
#import "MommyRequest.h"
#import "CommonViewController.h"

@implementation CommunityPersonListCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cellView.layer setBorderColor:[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.cornerRadius = 10;//half of the width
    
    _mentorImageView.layer.cornerRadius = 20;
    _mentorImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)toggleMentorAction:(id)sender {
    if([_mentorButtonImage.image isEqual:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"]]){
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:_mentorKey forKey:@"mento_key"];
        
        [[MommyRequest sharedInstance] mommyCommunityApiService:CommunityMentoInsert authKey:GET_AUTH_TOKEN parameters:param success:^(NSDictionary *data) {
            if([[NSString stringWithFormat:@"%@", [data objectForKey:@"code"]] isEqualToString:@"0"]){
                dispatch_sync(dispatch_get_main_queue(), ^{
                        [_mentorButtonImage setImage:[UIImage imageNamed:@"popup_btn_icon_mentor.png"]];
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
                    [_mentorButtonImage setImage:[UIImage imageNamed:@"popup_btn_icon_mentor_add.png"]];
                });
            }
        } error:^(NSError *error) {
            
        }];
    }
}
@end
