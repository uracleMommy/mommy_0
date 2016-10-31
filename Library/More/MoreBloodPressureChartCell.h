//
//  MoreBloodPressureChartCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 8..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreBloodPressureChartCellDelegate <NSObject>

@required

- (void) previousAction;

- (void) nextAction;

@end

@interface MoreBloodPressureChartCell : UITableViewCell<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblLately;

@property (strong, nonatomic) id<MoreBloodPressureChartCellDelegate> delegate;

- (IBAction)goPrevious:(id)sender;

- (IBAction)goNext:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *functionJson;

@property (assign, nonatomic) BOOL isFirst;

@end
