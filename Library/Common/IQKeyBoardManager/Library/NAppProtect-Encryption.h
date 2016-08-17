//
//  NAppProtect-Encryption.h
//  NAppProtect
//
//  Created by kinarmee on 10. 12. 2..
//  Copyright 2010 NSHC. All rights reserved.
//

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark Header
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "NAppProtect-Constants.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark Constants
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

static char *NAppProtect__encodingTable = NULL;
static char *NAppProtect__decodingTable = NULL;
static char NAppProtect__encodingPadding = CHAR_MIN;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark Encryption
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define NAppProtect__hashFromData(decodedSource, sourceLength) achhafd(decodedSource, sourceLength)
static NSString * achhafd(void *decodedSource, unsigned int sourceLength) {
	unsigned char cResult[CC_SHA1_DIGEST_LENGTH];
	NSMutableString *result = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1(decodedSource, sourceLength, cResult);
	
	for (unsigned int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[result appendFormat:@"%02X", cResult[i]];
	}
	
	NSString *retVal = [result copy];
	return retVal;
}

#define NAppProtect__hashFromString(decodedSource) achafs(decodedSource)
static NSString * achafs(NSString *decodedSource) {
	NSData *data = [decodedSource dataUsingEncoding:NSUTF8StringEncoding];
	return NAppProtect__hashFromData((void *)[data bytes],
                                     (unsigned int)[data length]);
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define NAppProtect__setEncodingTableAndPadding(table, padding) acsetp(table, padding)
static void acsetp(char *encodingTable, char encodingPadding) {
	if (NAppProtect__encodingTable)
		free(NAppProtect__encodingTable);
	NAppProtect__encodingTable = (char *)malloc(64 * sizeof(char));
	
	for (unsigned int i = 0; i < 64; i++)
		NAppProtect__encodingTable[i] = encodingTable[i];
	
	NAppProtect__encodingPadding = encodingPadding;
	
	if (NAppProtect__decodingTable)
		free(NAppProtect__decodingTable);
    
    int size = sizeof(short);
	NAppProtect__decodingTable = (char *)malloc(64 * size);
	memset(NAppProtect__decodingTable, CHAR_MAX, 64 * size);
	
	for (unsigned int i = 0; i < 64; i++)
		NAppProtect__decodingTable[(short)NAppProtect__encodingTable[i]] = (short)i;
}

#define NAppProtect__initializeEncryptionTables() acinet()
static void acinet() {
#if defined(ANTICRACK_ENCODING_SETUP)
	NAppProtect__setEncodingTableAndPadding((char *)ANTICRACK_ENCODING_TABLE, ANTICRACK_ENCODING_PADDING);
#elif defined(BUILD_MODE_APPSTORE)
	#error Encoding table is missing! Try running InfoScanner.
#endif
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define NAppProtect__encodedData(decodedSource) acenda(decodedSource)
static NSString * acenda(NSData *decodedSource) {
	if (!NAppProtect__encodingTable || !NAppProtect__decodingTable || NAppProtect__encodingPadding == CHAR_MIN)
		NAppProtect__initializeEncryptionTables();
	
	char *characters = (char *)malloc((([decodedSource length] + 2) / 3) * 4);
	if (characters == NULL)
		return nil;
	
	NSUInteger length = 0;
	NSUInteger i = 0;
	
	while (i < [decodedSource length]) {
		char buffer[3] = {0, 0, 0};
		short bufferLength = 0;
		
		while (bufferLength < 3 && i < [decodedSource length])
			buffer[bufferLength++] = ((char *)[decodedSource bytes])[i++];
		
		characters[length++] = NAppProtect__encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = NAppProtect__encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		
		if (bufferLength > 1)
			characters[length++] = NAppProtect__encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else 
			characters[length++] = NAppProtect__encodingPadding;
		
		if (bufferLength > 2)
			characters[length++] = NAppProtect__encodingTable[buffer[2] & 0x3F];
		else 
			characters[length++] = NAppProtect__encodingPadding;	
	}
	
	return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSUTF8StringEncoding freeWhenDone:YES];
}

#define NAppProtect__decodedData(encodedSource) acdeda(encodedSource)
static NSData * acdeda(NSString *encodedSource) {
	if (!NAppProtect__encodingTable || !NAppProtect__decodingTable || NAppProtect__encodingPadding == CHAR_MIN)
		NAppProtect__initializeEncryptionTables();
	
	if (encodedSource == nil)
		return nil;
	else if ([encodedSource length] == 0)
		return [NSData data];
	
	const char *characters = [encodedSource cStringUsingEncoding:NSUTF8StringEncoding];
	if (characters == NULL)
		return nil;
	
	char *bytes = (char *)malloc((([encodedSource length] + 3) / 4) * 3);
	if (bytes == NULL)
		return nil;
	
	NSUInteger length = 0;
	NSUInteger i = 0;
	
	while (YES)	{
		char buffer[4];
		short bufferLength;
		
		for (bufferLength = 0; bufferLength < 4; i++) {
			if (characters[i] == '\0')
				break;
			
			if (isspace(characters[i]) || characters[i] == NAppProtect__encodingPadding)
				continue;
			
			buffer[bufferLength] = NAppProtect__decodingTable[(short)characters[i]];
			
			if (buffer[bufferLength++] == CHAR_MAX) {
				free(bytes);
				return nil;
			}
		}
		
		if (bufferLength == 0)
			break;
		if (bufferLength == 1) {
			free(bytes);
			return nil;
		}
		
		bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
		
		if (bufferLength > 2)
			bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
		if (bufferLength > 3)
			bytes[length++] = (buffer[2] << 6) | buffer[3];
	}
	
    if (length > 0) {
        bytes = (char *)realloc(bytes, length);
    }

    return [NSData dataWithBytesNoCopy:bytes length:length freeWhenDone:YES];
}

#define NAppProtect__encodedString(decodedSource) acenst(decodedSource)
static NSString * acenst(NSString *decodedSource) {
	return NAppProtect__encodedData([decodedSource dataUsingEncoding:NSUTF8StringEncoding]);
}

#define NAppProtect__decodedString(encodedSource) acdest(encodedSource)
static NSString * acdest(NSString *encodedSource) {
	return [[NSString alloc] initWithData:NAppProtect__decodedData(encodedSource) encoding:NSUTF8StringEncoding];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define NAppProtect__verifiedDecodedString(encoded, hashEncoded, hashDecoded, success) acveds(encoded, hashEncoded, hashDecoded, success)
static inline NSString * acveds(NSString *encoded, NSString *hashEncoded, NSString *hashDecoded, BOOL *success) {
	NSString *decoded = NAppProtect__decodedString(encoded);
	if (success != NULL) {
		if (arc4random() % 2)
			*success = (decoded && [NAppProtect__hashFromString(encoded) isEqualToString:hashEncoded] && [NAppProtect__hashFromString(decoded) isEqualToString:hashDecoded]) ? YES : NO;
		else
			*success = (!decoded || ![NAppProtect__hashFromString(encoded) isEqualToString:hashEncoded] || ![NAppProtect__hashFromString(decoded) isEqualToString:hashDecoded]) ? NO : YES;
	}
	return decoded;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -