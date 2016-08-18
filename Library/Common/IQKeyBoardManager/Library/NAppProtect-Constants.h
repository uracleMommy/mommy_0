//
//  NAppProtect-Constants.h
//  NAppProtect
//
//  Created by kinarmee on 10. 12. 2..
//  Copyright 2010 NSHC. All rights reserved.
//

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark Header
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#import "NAppProtect-InfoScanner.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark Constants
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Set this to anything different than kAntiCrackNoCrackFound ONLY for debugging
#define ANTICRACK_FAKE_CRACK kAntiCrackNoCrackFound

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define kAntiCrackMissingInfo	INT_MIN
#define kAntiCrackNoCrackFound	0
#define kAntiCrackCrackFound	INT_MAX

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define kAntiCrackDecryptedBinaryMask			1 << 0 // 1
#define kAntiCrackMissingCodeResourcesMask		1 << 1 // 2
#define kAntiCrackModifiedExecutableFileMask	1 << 2 // 4
#define kAntiCrackModifiedHoneyPotStringsMask	1 << 3 // 8

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -