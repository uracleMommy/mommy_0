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

@property (assign) BOOL currentLastPageStatus; // 현재 마지막 페이지까지 로드가 되어있는지 여부

@property (assign) ProfessionalButtonKind professionalButtonKind;

@property (strong, nonatomic) NSString *afterCUDYN; // 입력/업데이트/삭제후 진입인지 판별

@end
