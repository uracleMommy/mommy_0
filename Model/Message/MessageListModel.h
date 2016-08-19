//
//  MessageListModel.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 19..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MessageListModel : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *listArray; // 리스트 정보

@property (strong, nonatomic) NSMutableDictionary *listImgArray; // 프로필 이미지 캐쉬 저장용 딕셔너리

@end