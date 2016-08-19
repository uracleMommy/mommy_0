//
//  DashBoardController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListController.h"

@interface DashBoardController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *pageViewContainer;

@property (strong, nonatomic) NSArray *scrollViewArray;

@property (strong, nonatomic) MessageListController *messageListController;

- (IBAction)MessagePopupAction:(id)sender;

@end