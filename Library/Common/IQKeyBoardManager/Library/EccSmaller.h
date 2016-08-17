//
//  NOtpGen.h
//  NOtp
//
//  Created by Kinamee on 11. 3. 3..
//  Copyright 2011 NSHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EccSmaller : NSObject {
    
	NSData *_publicKeyOfMine;
	NSData *_privateKeyOfMine;
    
	NSMutableData *_rcvPublicKeyDataFromServer;
	NSData *_sharedKey;
	
	//NSArray *_arrKeyNum;	
}

+(EccSmaller *)shared;

// 전문 무결성
-(NSString *)makeEncNoPadWithSeedkey:(NSString *)pPlainText seedKey:(NSData *)pSeedKey;
-(void)GenerateKeypair:(NSData **)vPublicKey privateKey:(NSData **)vPrivateKey;
-(void)DeriveKey:(NSData **)vSeedKey privateKeyOfMine:(NSData *)pPrivateKey publicKeyFromSvr:(NSData *)pPublicKey;
-(void)Sign:(NSData **)vData pPasswd:(NSData *)pPasswd pData:(NSData *)pData;
-(BOOL)Verify:(NSData *)pPasswd pData:(NSData *)pData pSign:(NSData *)pSign;
-(NSString *)byteArrayToHex:(NSData *)data;
-(NSData*)hexToByteArray:(NSString *)hexString;
-(NSString*)getGapString:(NSData *)pSeedKey privateKey:(NSData *)pPrivateKey;


// 공개키 붙여서 암호화
-(NSString *)makeEncNoPadWithSeedkey:(NSString *)pPlainText 
                              seedKey:(NSData *)pSeedKey 
                         pubkeyClinet:(NSData*)pPubkeyClient;

-(void)getKeyPare:(NSData **)vPublicKey privateKey:(NSData **)vPrivateKey;
-(void)getSequreKey:(NSData **)vSeedKey privateKeyOfMine:(NSData *)pPrivateKey publicKeyFromSvr:(NSData *)pPublicKey;
-(NSString*)getRandNum:(NSData *)pSeedKey;

@end
