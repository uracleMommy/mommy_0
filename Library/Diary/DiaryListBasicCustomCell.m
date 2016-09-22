//
//  DiaryListBasicCustomCell.m
//  co.medisolution
//
//  Created by uracle on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiaryListBasicCustomCell.h"

@implementation DiaryListBasicCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cellView.layer setBorderColor:[UIColor colorWithRed:153.0/255.0f green:153.0/255.0f  blue:153.0/255.0f alpha:1.0].CGColor];
    [_cellView.layer setBorderWidth:1.0f];
    _cellView.layer.cornerRadius = 10;//half of the width

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f  blue:217.0/255.0f alpha:1.0] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:3],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, -5);
    CGPathAddLineToPoint(path, NULL, _contentLabel.layer.preferredFrameSize.width - 38.0 ,-5);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[_contentLabel layer] addSublayer:shapeLayer];
    
//    _border = [CAShapeLayer layer];
//    _border.lineWidth = 200;
//    _border.strokeColor = [[UIColor blackColor] CGColor];
//    _border.fillColor = [[UIColor clearColor] CGColor];
//    _border.lineDashPattern = @[@4, @2];
////    _border.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5.f].CGPath;
//    [_contentLabel.layer addSublayer:_border];
    
//    [_contentLabel.layer setBorderWidth:5.0];
//    [_contentLabel.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_checkbox_off.png"]] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
