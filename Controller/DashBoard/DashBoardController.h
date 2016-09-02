//
//  DashBoardController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 16..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListController.h"

@protocol DashBoardControllerDelegate;

@interface DashBoardController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *pageViewContainer;

@property (strong, nonatomic) NSArray *scrollViewArray;

@property (strong, nonatomic) MessageListController *messageListController;

@property (strong, nonatomic) id<DashBoardControllerDelegate> delegate;

- (IBAction)MessagePopupAction:(id)sender;

- (IBAction)SingleImageView:(id)sender;

- (IBAction)MultiImageView:(id)sender;

- (IBAction)NoticeView:(id)sender;

- (IBAction)MessageModal:(id)sender;

@end

@protocol DashBoardControllerDelegate <NSObject>

@optional

- (void) presentMessage;

- (void) presentWeight;

@end