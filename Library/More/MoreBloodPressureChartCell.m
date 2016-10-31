//
//  MoreBloodPressureChartCell.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreBloodPressureChartCell.h"

@implementation MoreBloodPressureChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _webView.delegate = self;
    
    // 컨테이너뷰 라운드, 보더 처리
    _containerView.layer.borderColor = [[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f] CGColor];
    _containerView.layer.borderWidth = 1.0f;
    _containerView.layer.cornerRadius = 10;
    _isFirst = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (_isFirst) {
        
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initChart('%@')", _functionJson]];
        _isFirst = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goPrevious:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(previousAction)]) {
        
        [self.delegate previousAction];
    }
}

- (IBAction)goNext:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(nextAction)]) {
        
        [self.delegate nextAction];
    }
}

@end
