//
//  MommyRequest.m
//  http_module
//
//  Created by OGGU on 2016. 8. 10..
//  Copyright © 2016년 URACLE. All rights reserved.
//

#import "MommyRequest.h"

static NSString *_mainDomain = @"http://211.241.199.153:9100/medisolution"; // 도메인 주소

@implementation MommyRequest

static MommyRequest* instanceMommyRequest;

+ (MommyRequest *)sharedInstance {
    
    @synchronized(self) {
        
        if (!instanceMommyRequest) {
            
            instanceMommyRequest = [[MommyRequest alloc] init];
            return instanceMommyRequest;
        }
    }
    
    return instanceMommyRequest;
}

#pragma mark 서비스 리퀘스트
- (void) mommyService : (NSString *) serviceUrl parameter : (id) params, ... {
    
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    id eachObjects;
    va_list argumentList;
    
    if (params) {
        
        [arguments addObject:params];
        va_start(argumentList, params);
        
        while ((eachObjects =  va_arg(argumentList, id))) {
            
            [arguments addObject:eachObjects];
        }
        
        va_end(argumentList);
    }
    
    // arguments 안에 파라미터 배열 들어있음
    
//    [self mommyApiService:LoginCheck parameters:@"" success:nil error:nil];
    
}

#pragma http 리퀘스트
- (void) mommyRequestURL : (NSString *) requestUrl parameters : (NSString *) parameters {
    
}

#pragma mark 로그인 서비스 호출
- (void) mommyLoginApiService : (MommyLoginWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestLoginUrlType:serviceType];
    
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *contentType = @"application/json";
    NSString *authorization = authKey;
    NSMutableData *body = [NSMutableData data];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    
    // dictionary -> json
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [body appendData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error) {
        if (error != nil) {
            
            errorBlock(error);
            return;
        }
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        successBlock(jsonDic);
        
    }] resume];
}

#pragma mark 회원관리 서비스 호출
- (void) mommySignInApiService : (MommySignInWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestSignInUrlType:serviceType];
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *contentType = @"application/json";
    NSString *authorization = [NSString stringWithFormat:@"Bearer %@", authKey];
    NSMutableData *body = [NSMutableData data];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    
    // dictionary -> json
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [body appendData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error) {
        
        if (error != nil) {
            
            errorBlock(error);
            return;
        }
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        successBlock(jsonDic);
        
        
    }] resume];
}

#pragma mark 이미지 업로드 서비스 호출
- (void) mommyImageUploadApiService : (UIImage *) image success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestImageUploadUrl];
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *boundary = @"0xKhTmLbOuNdArY";
    request.HTTPMethod = @"POST";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    NSMutableData *body = [NSMutableData data];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"abc.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // jpeg 변환
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                              NSError *error) {
        
        if (error != nil) {
            
            errorBlock(error);
            return;
        }
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        successBlock(jsonDic);
        
    }] resume];
}

@end


#pragma mark API 리스트
@implementation MommyHttpUrls

static MommyHttpUrls* instanceMommyHttpUrls;

+ (MommyHttpUrls *)sharedInstance {
    
    @synchronized(self) {
        
        if (!instanceMommyHttpUrls) {
            
            instanceMommyHttpUrls = [[MommyHttpUrls alloc] init];
            return instanceMommyHttpUrls;
        }
    }
    
    return instanceMommyHttpUrls;
}

#pragma mark 로그인 관련 API 주소



#pragma mark 회원가입 관련


#pragma mark 로그인 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestLoginUrlType : (MommyLoginWebServiceType) serviceType {
    
    switch (serviceType) {
        
            // 로그인
        case LoginCheck:
            return [_mainDomain stringByAppendingString: @"/api/user/login"];
            break;
            
            // 자동 로그인
        case AutoLogin:
            return [_mainDomain stringByAppendingString: @"/api/user/auth"];
            break;
            
            // 인증번호 받기
        case AuthNumber:
            return [_mainDomain stringByAppendingString: @"/api/user/getSmsMessage"];
            break;
            
            // 계정 잠금 해제
        case UnlockMember:
            return [_mainDomain stringByAppendingString: @"/api/user/unlock-id"];
            break;
            
            // 비밀번호 재설정
        case ResetPassword:
            return [_mainDomain stringByAppendingString: @"/api/user/password/reset"];
            break;
            
            // 신규 비밀번호 생성
        case SetPassword:
            return [_mainDomain stringByAppendingString: @"/api/user/password/new"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 회원가입 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestSignInUrlType : (MommySignInWebServiceType) serviceType {
    
    switch (serviceType) {
        case MemberSignUp:
            return [_mainDomain stringByAppendingString: @"/api/join/signup"];
            break;
            
        case IdDuplicateCheck:
            return [_mainDomain stringByAppendingString: @"/api/join/overlap/id"];
            break;
            
        case NickNameDuplicateCheck:
            return [_mainDomain stringByAppendingString:@"/api/join/overlap/nickname"];
            break;
            
        case GetAddress:
            return [_mainDomain stringByAppendingString: @"/api/join/address"];
            break;
            
        case InsertUserProfile:
            return [_mainDomain stringByAppendingString: @"/api/join/insert/user-profile"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 이미지 업로드
- (NSString *) requestImageUploadUrl {
    
    return [_mainDomain stringByAppendingString: @"/api/image/upload"];
}

@end




































