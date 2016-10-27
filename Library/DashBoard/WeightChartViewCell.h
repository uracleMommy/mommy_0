//
//  WeightChartViewCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 2..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeightChartViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@property (weak, nonatomic) IBOutlet UILabel *lblWeight;

@property (weak, nonatomic) IBOutlet UILabel *lblRFirstRangeWeight;

@property (weak, nonatomic) IBOutlet UILabel *lblSecondRangeWeight;

@property (weak, nonatomic) IBOutlet UILabel *lblWeightAppraisal;

- (IBAction)goPrevious:(id)sender;

- (IBAction)goNext:(id)sender;

@end
