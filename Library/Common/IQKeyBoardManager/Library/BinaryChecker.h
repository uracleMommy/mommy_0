//
//  BinaryChecker.h
//  SmpAppProtect
//
//  Created by Park Kinam on 12. 5. 6..
//  Copyright (c) 2012년 NSHC. All rights reserved.
//

#import <UIKit/UIKit.h>

struct OffsetAndLength {
    NSInteger offset;
    NSInteger length;
};
typedef struct OffsetAndLength OffsetAndLength;

typedef enum {
    NS_MD5,
    NS_SHA256
} HashAlgorithm;

void bitwiseXOR(char *value1, char *value2, int length1, int length2, char **outValue, int *outLength);


@interface BinaryChecker : NSObject {
    
}

@property (nonatomic, assign) BOOL useEncryptServerPattern;
@property (nonatomic, assign) BOOL enableMakeHashForOriginalBinary;


+(BinaryChecker*)shared;

// 1.2 버전 API
-(NSString*)getBinaryHashNJB:(NSString*)pPubkeyFromServer 
              flagFromServer:(NSString*)pFlagFromServer 
                     pattern:(NSString*)pPattern; 

// 1.3 버전 API
-(NSString*)getBinaryHashNJB:(NSString*)pPubkeyFromServer
              flagFromServer:(NSString*)pFlagFromServer
                     pattern:(NSString*)pPattern
                      userID:(NSString*)pUserID
                cellPhoneNum:(NSString*)pCellPhoneNum;

// 1.4 버전 ~ 1.6버전 API
-(NSString*)getBinaryHashNJB:(NSString*)pPubkeyFromServer
              flagFromServer:(NSString*)pFlagFromServer
                     pattern:(NSString*)pPattern
                      userID:(NSString*)pUserID
                cellPhoneNum:(NSString*)pCellPhoneNum
                  macAddress:(NSString*)pMacAddress;

// 1.6.1 ~ 1.6.2 버전 API
-(NSString*)getBinaryHashNJB:(NSString*)pPubkeyFromServer
              flagFromServer:(NSString*)pFlagFromServer
                     pattern:(NSString*)pPattern
                      userID:(NSString*)pUserID
               hashAlgorithm:(HashAlgorithm)hashAlgorithm;

// 1.7.0 버전 API
-(NSString*)makeVerifyDataWithPublicKey:(NSString*)pubkeyFromServer
                            withPattern:(NSString*)pattern
                                 userID:(NSString*)userID
                          hashAlgorithm:(HashAlgorithm)hashAlgorithm;

// 해쉬값 가져오기
-(NSString*)getBinaryOriginHash:(HashAlgorithm)hashAlgorithm;

@end
