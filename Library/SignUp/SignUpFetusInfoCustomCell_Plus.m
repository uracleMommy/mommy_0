//
//  SignUpFetusInfoCustomCell_Plus.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "SignUpFetusInfoCustomCell_Plus.h"

@implementation SignUpFetusInfoCustomCell_Plus
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _plusButton.layer.cornerRadius = 20;//half of the width
    _plusButton.layer.borderColor = [UIColor colorWithRed:132.0/255.0f green:68.0/255.0f  blue:240.0/255.0f alpha:1.0].CGColor;
    _plusButton.layer.borderWidth=1.0f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addFetusCell:(id)sender {
    NSLog(@"PSH addFetusCell");
    [delegate addTableCell];
}
@end
