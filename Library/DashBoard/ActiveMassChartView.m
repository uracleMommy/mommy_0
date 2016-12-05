//
//  ActiveMassChartView.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "ActiveMassChartView.h"

@implementation ActiveMassChartView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _webView.delegate = self;
    for (id subview in _webView.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
    
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
    
    if ([self.delegate respondsToSelector:@selector(goNext)]) {
        
        [self.delegate goNext];
    }
}

- (IBAction)goNext:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(goPrevious)]) {
        
        [self.delegate goPrevious];
    }
}

- (IBAction)commentButtonAction:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                    message:_lblComment.text
                                                   delegate:self
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil, nil];
    [alert show];

}

@end
