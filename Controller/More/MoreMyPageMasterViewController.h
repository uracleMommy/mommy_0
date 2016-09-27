//
//  MoreMyPageMasterViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreMyPageSubImageController.h"
#import "MoreMyPageSubInfoPanelController.h"

@interface MoreMyPageMasterViewController : CommonViewController

@property (strong, nonatomic) MoreMyPageSubImageController *moreMyPageSubImageController;

@property (strong, nonatomic) MoreMyPageSubInfoPanelController *moreMyPageSubInfoPanelController;

#pragma mark 모달 창 관련

- (IBAction)closeModal:(id)sender;

- (void) modalNickName;

- (void) modalFetusChange;

@end
