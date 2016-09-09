//
//  MoreMainModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 7..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoreMainModelDelegate;

@interface MoreMainModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayList;

@property (strong, nonatomic) id<MoreMainModelDelegate> delegate;

@end

@protocol MoreMainModelDelegate <NSObject>

@required

- (void) selectedIndexPath : (NSIndexPath *) indexPath;

@end