//
//  DiarySegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DiarySegue.h"
#import "TabbarDiaryNavController.h"

@implementation DiarySegue

- (void) perform {
    
    TabbarDiaryNavController *diaryContainerNavi =  (TabbarDiaryNavController *)self.sourceViewController;
    UIViewController *DiaryController = (UIViewController *)self.destinationViewController;
    [diaryContainerNavi pushViewController:DiaryController animated:NO];
}

@end
