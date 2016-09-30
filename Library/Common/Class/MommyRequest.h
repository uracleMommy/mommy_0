//
//  MommyRequest.h
//  http_module
//
//  Created by OGGU on 2016. 8. 10..
//  Copyright © 2016년 URACLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma 로그인 관련 서비스
typedef enum {
    
    LoginCheck,
    AutoLogin,
    AuthNumber,
    UnlockMember,
    ResetPassword,
    SetPassword
} MommyLoginWebServiceType;

typedef enum {
    
    MemberSignUp,
    DuplicateCheck
} MommySignInWebServiceType;

#pragma 추후 추가 관리


#pragma 블록 타입 정의
typedef void (^MommyApiServiceSuccessBlock) ( NSDictionary *data );
typedef void (^MommyApiServiceErrorBlock) ( NSError *error );

@interface MommyRequest : NSObject

+ (MommyRequest *) sharedInstance;

- (void) mommyLoginApiService : (MommyLoginWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

- (void) mommySignInApiService : (MommySignInWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

- (void) mommyImageUploadApiService : (UIImage *) image success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

@end

@interface MommyHttpUrls : NSObject

+ (MommyHttpUrls *) sharedInstance;

- (NSString *) requestLoginUrlType : (MommyLoginWebServiceType) serviceType;

- (NSString *) requestSignInUrlType : (MommySignInWebServiceType) serviceType;

- (NSString *) requestImageUploadUrl;

@end
