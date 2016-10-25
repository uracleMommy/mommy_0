//
//  MoreEquipmentListCell.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreEquipmentListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *lblDotLine;

@property (weak, nonatomic) IBOutlet UILabel *lblDeviceName;

@property (weak, nonatomic) IBOutlet UILabel *lblModelName;

- (IBAction)goUnPairing:(id)sender;

@end
