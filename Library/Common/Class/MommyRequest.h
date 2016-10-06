//
//  MommyRequest.h
//  http_module
//
//  Created by OGGU on 2016. 8. 10..
//  Copyright © 2016년 URACLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark API 열거형

#pragma 로그인 관련 열거형
typedef enum {
    
    LoginCheck,
    AutoLogin,
    AuthNumber,
    UnlockMember,
    ResetPassword,
    SetPassword
} MommyLoginWebServiceType;

#pragma 회원가입 관련 열거형
typedef enum {
    
    MemberSignUp,
    IdDuplicateCheck,
    NickNameDuplicateCheck,
    GetAddress,
    InsertUserProfile
} MommySignInWebServiceType;

#pragma 쪽지 관련 열거형
typedef enum {
    
    MessageList,
    MessageSend,
    MessageDelegate
} MommyMessageWebServiceType;

#pragma 다이어리 관련 열거형
typedef enum {
    
    DiaryList,
    DiaryInsert,
    DiaryDetail,
    DiaryDelete,
    DiaryUpdate
} MommyDiaryWebServiceType;

#pragma 블록 타입 정의
typedef void (^MommyApiServiceSuccessBlock) ( NSDictionary *data );
typedef void (^MommyApiServiceErrorBlock) ( NSError *error );

#pragma mark API 리퀘스트 목록

@interface MommyRequest : NSObject

+ (MommyRequest *) sharedInstance;

#pragma 로그인 관련
- (void) mommyLoginApiService : (MommyLoginWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

#pragma 회원가입 관련
- (void) mommySignInApiService : (MommySignInWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

#pragma 쪽지 관련
- (void) mommyMessageApiService : (MommyMessageWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

#pragma 다이어리 관련
- (void) mommyDiaryApiService : (MommyDiaryWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

#pragma 이미지 업로드 관련
- (void) mommyImageUploadApiService : (UIImage *) image success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock;

@end


#pragma mark API 주소 정의
@interface MommyHttpUrls : NSObject

+ (MommyHttpUrls *) sharedInstance;

- (NSString *) requestLoginUrlType : (MommyLoginWebServiceType) serviceType;

- (NSString *) requestSignInUrlType : (MommySignInWebServiceType) serviceType;

- (NSString *) requestMessageUrlType : (MommyMessageWebServiceType) serviceType;

- (NSString *) requestDiaryUrlType : (MommyDiaryWebServiceType) serviceType;

- (NSString *) requestImageUploadUrl;

- (NSString *) requestImageDownloadUrl;

@end
