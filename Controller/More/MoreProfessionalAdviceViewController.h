//
//  MoreProfessionalAdviceViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 13..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreProfessionalButtonViewController.h"
#import "MoreProfessionalAdviceModel.h"

@interface MoreProfessionalAdviceViewController : CommonViewController<MoreProfessionalButtonViewControllerDelegate, MoreProfessionalAdviceModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreProfessionalAdviceModel *moreProfessionalAdviceModel;

@property (strong, nonatomic) MoreProfessionalButtonViewController *moreProfessionalButtonViewController;

- (IBAction)professionalListAction:(id)sender;

- (IBAction)closeView:(id)sender;

@end
