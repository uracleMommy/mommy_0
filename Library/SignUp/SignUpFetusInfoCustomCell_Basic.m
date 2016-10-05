//
//  SignUpFetusInfoCustomCell_Basic.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpFetusInfoCustomCell_Basic.h"

@implementation SignUpFetusInfoCustomCell_Basic
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView.layer setBorderColor:[UIColor colorWithRed:236.0/255.0f green:236.0/255.0f  blue:236.0/255.0f alpha:1.0].CGColor];
    [self.contentView.layer setBorderWidth:0.5f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


- (IBAction)deleteInputContents:(id)sender {
    NSLog(@"PSH deleteInputContents");
    [delegate deleteTableCell:sender];
    _fetusNameTextField.text = @"";
}
@end
