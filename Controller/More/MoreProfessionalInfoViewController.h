//
//  MoreProfessionalInfoViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "DZNSegmentedControl.h"

@interface MoreProfessionalInfoViewController : CommonViewController

@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segmentView;

@property (weak, nonatomic) IBOutlet UITextView *txtContent;

@property (strong, nonatomic) NSArray *arrayList;

@end
