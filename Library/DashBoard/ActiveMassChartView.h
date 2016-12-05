//
//  ActiveMassChartView.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 6..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActiveMassChartViewDelegate <NSObject>

@required

- (void) goPrevious;

- (void) goNext;

@end

@interface ActiveMassChartView : UITableViewCell<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) NSString *functionJson;

@property (assign, nonatomic) BOOL isFirst;

@property (strong, nonatomic) id<ActiveMassChartViewDelegate> delegate;

- (IBAction)goPrevious:(id)sender;

- (IBAction)goNext:(id)sender;
- (IBAction)commentButtonAction:(id)sender;

@end
