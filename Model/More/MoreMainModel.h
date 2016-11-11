//
//  MoreMainModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MommyRequest.h"

@protocol MoreMainModelDelegate;

@interface MoreMainModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *arrayList;

@property (strong, nonatomic) id<MoreMainModelDelegate> delegate;

@property (strong, nonatomic) UIImage *profileImg;

@end

@protocol MoreMainModelDelegate <NSObject>

@required

- (void) selectedIndexPath : (NSInteger) index;

@end
