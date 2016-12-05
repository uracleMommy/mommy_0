//
//  MommyRequest.m
//  http_module
//
//  Created by OGGU on 2016. 8. 10..
//  Copyright © 2016년 URACLE. All rights reserved.
//

#import "MommyRequest.h"

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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma mark 쪽지관리 서비스 호출
- (void) mommyMessageApiService : (MommyMessageWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestMessageUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
    
}
#pragma mark 알림 서비스 호출
- (void) mommyPushNoticeApiService : (MommyPushNoticeWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestPushNoticeUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
    
}

#pragma mark 전문가 상담 서비스 호출 
- (void) mommyProfessionalAdviceApiService : (MommyProfessionalAdviceWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestProfessionalAdviceUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma 마이페이지 서비스 호출
- (void) mommyMyPageApiService : (MommyMyPageWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock{
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestMyPageUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma mark 이미지 업로드 서비스 호출
- (void) mommyMyPageImageUploadApiService : (UIImage *) image authKey:(NSString *)authKey success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestMyPageImageUploadUrl];
    
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *boundary = @"0xKhTmLbOuNdArY";
    request.HTTPMethod = @"POST";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    NSString *authorization = [NSString stringWithFormat:@"Bearer %@", authKey];
    NSMutableData *body = [NSMutableData data];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
    }] resume];
}

#pragma 다이어리 서비스 호출
- (void) mommyDiaryApiService : (MommyDiaryWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock{
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestDiaryUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma 커뮤니티 서비스 호출
- (void) mommyCommunityApiService : (MommyCommunityWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock{
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestCommunityUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

- (void) mommyDashboardApiService : (MommyDashboardWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestDashboardUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

- (void) mommyPointApiService : (MommyPointWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestPointUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma mark 혈압관리 API
- (void) mommyBloodPressureApiService : (MommyBloodPressureWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestBloodPressureUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma mark 차트 관련 서비스 호출
- (void) mommyChartApiService : (MommyChartWebServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestChartInfoUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

#pragma mark 금주의 프로그램 관련 서비스 호출
- (void) mommyWeekProgramApiService : (MommyWeekProgramServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestWeekProgramUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
    }] resume];
}

- (void) mommyMoreEtcApiService : (MommyMoreEtcServiceType) serviceType authKey : (NSString *) authKey parameters : (NSDictionary *) parameters success : (MommyApiServiceSuccessBlock) successBlock error : (MommyApiServiceErrorBlock) errorBlock {
    
    NSString *requestUrl = [[MommyHttpUrls sharedInstance] requestMoreEtcUrlType:serviceType];
    
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
        
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
        if([[jsonDic objectForKey:@"code"] intValue] == -777){
            AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate go_story_board:@"MembershipLogin"];
        }else{
            successBlock(jsonDic);
        }
        
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
            
        case FindId:
            return [_mainDomain stringByAppendingString: @"/api/user/find/id"];
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
            
        case RecommendWeight:
            return [_mainDomain stringByAppendingString: @"/api/join/recommend-weight"];
            break;
        default:
            return @"";
            break;
    }
}

#pragma mark 쪽지 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestMessageUrlType : (MommyMessageWebServiceType) serviceType {
    
    switch (serviceType) {
        case MessageList:
            return [_mainDomain stringByAppendingString: @"/api/message/list"];
            break;
            
        case MessageSend:
            return [_mainDomain stringByAppendingString: @"/api/message/send"];
            break;
            
        case MessageDelegate:
            return [_mainDomain stringByAppendingString: @"/api/message/delete"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 푸쉬알림 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestPushNoticeUrlType : (MommyPushNoticeWebServiceType) serviceType {
    
    switch (serviceType) {
            
        case PushNoticeList:
            return [_mainDomain stringByAppendingString: @"/api/push/list"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 전문가 상담 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestProfessionalAdviceUrlType : (MommyProfessionalAdviceWebServiceType) serviceType {
    
    switch (serviceType) {
            
        case ProfessionalAdviceList:
            return [_mainDomain stringByAppendingString: @"/api/qna/list"];
            break;
            
        case ProfessionalList:
            return [_mainDomain stringByAppendingString: @"/api/qna/professor-list"];
            break;
            
        case ProfessionalAdviceContentInsert:
            return [_mainDomain stringByAppendingString: @"/api/qna/insert"];
            break;
            
        case ProfessionalAdviceContentDelete:
            return [_mainDomain stringByAppendingString: @"/api/qna/delete"];
            break;
            
        case ProfessionalAdviceDetail:
            return [_mainDomain stringByAppendingString: @"/api/qna/detail"];
            break;
            
        case ProfessionalAdviceContentUpdate:
            return [_mainDomain stringByAppendingString: @"/api/qna/update"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 마이페이지 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestMyPageUrlType : (MommyMyPageWebServiceType) serviceType {
    
    switch (serviceType) {
        case MyPageProfile:
            return [_mainDomain stringByAppendingString: @"/api/mypage/profile"];
            break;
            
        case MyPageDeleteUser:
            return [_mainDomain stringByAppendingString: @"/api/mypage/delete/user"];
            break;
            
        case MyPageUpdateProfile:
            return [_mainDomain stringByAppendingString: @"/api/mypage/update/profile"];
            break;
            
        case MyPageUpdatePassword:
            return [_mainDomain stringByAppendingString: @"/api/mypage/update/password"];
            break;
            
        default:
            return @"";
            break;
    }

}

#pragma mark 마이페이지 이미지 업로드
- (NSString *) requestMyPageImageUploadUrl {
    
    return [_mainDomain stringByAppendingString: @"/api/mypage/update/profile-img"];
}

#pragma mark 다이어리 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestDiaryUrlType : (MommyDiaryWebServiceType) serviceType {
    
    switch (serviceType) {
        case DiaryList:
            return [_mainDomain stringByAppendingString: @"/api/diary/list"];
            break;
            
        case DiaryInsert:
            return [_mainDomain stringByAppendingString: @"/api/diary/insert"];
            break;
            
        case DiaryDetail:
            return [_mainDomain stringByAppendingString: @"/api/diary/detail"];
            break;
            
        case DiaryDelete:
            return [_mainDomain stringByAppendingString: @"/api/diary/delete"];
            break;
            
        case DiaryUpdate:
            return [_mainDomain stringByAppendingString: @"/api/diary/update"];
            break;
            
        case GpsToAddress:
            return [_mainDomain stringByAppendingString:@"/api/diary/gps-to-address"];
            break;
            
        case MonthEmoticon:
            return [_mainDomain stringByAppendingString:@"/api/diary/month-emoticon"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 커뮤니티 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestCommunityUrlType : (MommyCommunityWebServiceType) serviceType {
    
    switch (serviceType) {
        case CommunityGroupList :
            return [_mainDomain stringByAppendingString: @"/api/community/group/list"];
            break;
            
        case CommunityMentoList :
            return [_mainDomain stringByAppendingString: @"/api/community/mento/list"];
            break;
            
        case CommunityMentoDelete :
            return [_mainDomain stringByAppendingString: @"/api/community/mento/delete"];
            break;
            
        case CommunityMentoInsert :
            return [_mainDomain stringByAppendingString: @"/api/community/mento/insert"];
            break;
            
        case CommunityMentoBoardList :
            return [_mainDomain stringByAppendingString: @"/api/community/mento/board/list"];
            break;
            
        case CommunityGroupBoardList :
            return [_mainDomain stringByAppendingString: @"/api/community/group/board/list"];
            break;
            
        case CommunityDelete :
            return [_mainDomain stringByAppendingString: @"/api/community/delete"];
            break;
            
        case CommunityLike :
            return [_mainDomain stringByAppendingString: @"/api/community/like"];
            break;
            
        case CommunityMentoProfile :
            return [_mainDomain stringByAppendingString: @"/api/community/mento/profile"];
            break;
            
        case CommunityReplyInfo :
            return [_mainDomain stringByAppendingString: @"/api/community/reply/info"];
            break;
            
        case CommunityReplyList :
            return [_mainDomain stringByAppendingString: @"/api/community/reply/list"];
            break;
            
        case CommunityInsertReply :
            return [_mainDomain stringByAppendingString: @"/api/community/insert/reply"];
            break;
            
        case CommunityGroupMentoList :
            return [_mainDomain stringByAppendingString: @"/api/community/group/mento/list"];
            break;
            
        case CommunityInsert :
            return [_mainDomain stringByAppendingString: @"/api/community/insert"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 대쉬보드 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestDashboardUrlType : (MommyDashboardWebServiceType) serviceType {
    
    switch (serviceType) {
        case DashboardMain:
            return [_mainDomain stringByAppendingString: @"/api/main/info"];
            break;
        case DashboardQuestionInfoInsert:
            return [_mainDomain stringByAppendingString: @"/api/main/medical/insert"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 포인트 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestPointUrlType : (MommyPointWebServiceType) serviceTyp {
    
    switch (serviceTyp) {
            
        case PointInfo:
            return [_mainDomain stringByAppendingString: @"/api/point/info"];
            break;
            
        case PointList:
            return [_mainDomain stringByAppendingString: @"/api/point/list"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 혈압관리 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestBloodPressureUrlType : (MommyBloodPressureWebServiceType) serviceType {
    
    switch (serviceType) {
        case BloodPressureList:
            return [_mainDomain stringByAppendingString: @"/api/pressure/list"];
            break;
            
        case BloodPressureInsert:
            return [_mainDomain stringByAppendingString: @"/api/pressure/insert"];
            break;
        case BloodPressureDelete:
            return [_mainDomain stringByAppendingString: @"/api/pressure/delete"];
            break;
            
        default:
            return @"";
            break;
    }
}

#pragma mark 차트 관련 리퀘스트 주소 리턴 메서드
- (NSString *) requestChartInfoUrlType : (MommyChartWebServiceType) serviceType {
    
    switch (serviceType) {
            
        case ChartWeightDailyGraph:
            return [_mainDomain stringByAppendingString: @"/api/weight/daily-graph"];
            break;
            
        case ChartWeightWeeklyGraph:
            return [_mainDomain stringByAppendingString: @"/api/weight/weekly-graph"];
            break;
            
        case ChartWeightLogInsert:
            return [_mainDomain stringByAppendingString: @"/api/weight/insert"];
            break;
            
        case ChartStepDaily:
            return [_mainDomain stringByAppendingString: @"/api/step/daily"];
            break;
            
        case ChartStepWeekly:
            return [_mainDomain stringByAppendingString: @"/api/step/weekly"];
            break;
            
        case ChartStepGraph:
            return [_mainDomain stringByAppendingString: @"/api/step/graph"];
            break;
            
            
        default:
            return @"";
            break;
    }
}

- (NSString *) requestWeekProgramUrlType : (MommyWeekProgramServiceType) serviceType {
    
    switch (serviceType) {
        case WeekProgramHealthList:
            return [_mainDomain stringByAppendingString: @"/api/program/health/list"];
            break;
            
        case WeekProgramSportsList:
            return [_mainDomain stringByAppendingString: @"/api/program/sports/list"];
            break;
            
        case WeekProgramNutritionList:
            return [_mainDomain stringByAppendingString: @"/api/program/nutrition/list"];
            break;
            
        case WeekProgramHealthDetailInfo:
            return [_mainDomain stringByAppendingString: @"/api/program/health/detail"];
            break;
            
        case WeekProgramSportsDetailInfo:
            return [_mainDomain stringByAppendingString: @"/api/program/sports/detail"];
            break;
            
        case WeekProgramNutritionDetailInfo:
            return [_mainDomain stringByAppendingString: @"/api/program/nutrition/detail"];
            break;
            
        default:
            return @"";
            break;
    }
}

- (NSString *) requestMoreEtcUrlType : (MommyMoreEtcServiceType) serviceType {
    
    switch (serviceType) {
        case MoreEtcWeekCheckList:
            return [_mainDomain stringByAppendingString: @"/api/check/list"];
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

#pragma mark 이미지 다운로드
- (NSString *) requestImageDownloadUrl {
    
    return [_mainDomain stringByAppendingString: @"/api/image/view"];
}

@end




































