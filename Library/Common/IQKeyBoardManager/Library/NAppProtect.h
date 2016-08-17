//
//  NAppProtect.h
//  NAppProtect
//
//  Created by kinarmee on 10. 12. 2..
//  Copyright 2010 NSHC. All rights reserved.
//

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark  Header
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#import <Foundation/Foundation.h>

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <sys/types.h>
#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>

typedef int (*ptrace_ptr_t) (int _request, pid_t _pid, caddr_t _addr, int _data);

#ifndef PT_DENY_ATTACH
#define  PT_DENY_ATTACH 31
#endif

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#import "NAppProtect-Constants.h"
#import "NAppProtect-Encryption.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

int main(int argc, char *argv[]);

#define runAntiDebugging() AmIBeingDebugged()
static BOOL runAntiDebugging()
{
    int                 junk;
    int                 mib[4];
    struct kinfo_proc   info;
    size_t              size;
    
    info.kp_proc.p_flag = 0;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
    
    size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);
    
    return ( (info.kp_proc.p_flag & P_TRACED) != 0 );
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark NAppProtect
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define NAppProtect__denyDebugger() acnyde()
static __inline__ void acnyde() {
#if defined(BUILD_MODE_APPSTORE)
#if defined(ANTICRACK_PTRACE_STRING_ENCODED) && defined(ANTICRACK_PTRACE_STRING_ENCODED_HASH) && defined(ANTICRACK_PTRACE_STRING_DECODED_HASH)
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    
    BOOL successPtraceString = NO;
    NSString *ptraceString = NAppProtect__verifiedDecodedString(ANTICRACK_PTRACE_STRING_ENCODED,
                                                                ANTICRACK_PTRACE_STRING_ENCODED_HASH,
                                                                ANTICRACK_PTRACE_STRING_DECODED_HASH,
                                                                &successPtraceString);
	
    if (successPtraceString) {
        ptrace_ptr_t ptrace_ptr = (ptrace_ptr_t)dlsym(handle, [ptraceString cStringUsingEncoding:NSUTF8StringEncoding]);
        ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    }
    dlclose(handle);
#else
#error Encoded strings are missing! Try running InfoScanner.
#endif
#endif
}

#define NAppProtect__isEncrypted() acryed()
static inline BOOL acryed() {
#if TARGET_IPHONE_SIMULATOR
	return YES;
#else
    const struct mach_header *header;
    Dl_info dlinfo;
	
    if (dladdr((void *)main, &dlinfo) == 0 || dlinfo.dli_fbase == NULL) {
        return NO;
    }
	
    header = (struct mach_header *)dlinfo.dli_fbase;
	struct load_command *cmd = (struct load_command *) (header+1);
	
    for (uint32_t i = 0; cmd != NULL && i < header->ncmds; i++) {
        if (cmd->cmd == LC_ENCRYPTION_INFO) {
            struct encryption_info_command *crypt_cmd = (struct encryption_info_command *)cmd;
			
            if (crypt_cmd->cryptid < 1) {
                return NO;
            }
			
			return YES;
        }
        cmd = (struct load_command *)((uint8_t *) cmd + cmd->cmdsize);
    }
	
	return NO;
#endif
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define cracked() acrake()
static inline int acrake() {
#if ANTICRACK_FAKE_CRACK != kAntiCrackNoCrackFound
	return ANTICRACK_FAKE_CRACK;
#elif TARGET_IPHONE_SIMULATOR || !defined(BUILD_MODE_APPSTORE) || defined(LITE_VERSION)
	return kAntiCrackNoCrackFound;
#else
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int suspect = (NAppProtect__isEncrypted()) ? kAntiCrackNoCrackFound : kAntiCrackDecryptedBinaryMask;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
#if defined(ANTICRACK_NSBUNDLE_STRING_ENCODED) && defined(ANTICRACK_MAINBUNBLE_STRING_ENCODED) && defined(ANTICRACK_BUNDLEPATH_STRING_ENCODED) && defined(ANTICRACK_EXECUTABLEPATH_STRING_ENCODED) && defined(ANTICRACK_FILEEXISTSATPATH_STRING_ENCODED) && defined(ANTICRACK_ATTRIBUTESOFITEMATPATH_STRING_ENCODED) && defined(ANTICRACK_FILEMODIFICATIONDATE_STRING_ENCODED) && defined(ANTICRACK_CODERESOURCES_STRING_ENCODED) && defined(ANTICRACK_CODESIGNATURE_STRING_ENCODED) && defined(ANTICRACK_PKGINFODIRECTORY_STRING_ENCODED)
	Class NSBundleClass = NSClassFromString(NAppProtect__decodedString(ANTICRACK_NSBUNDLE_STRING_ENCODED));									// NSBundle
	SEL mainBundleSelector = NSSelectorFromString(NAppProtect__decodedString(ANTICRACK_MAINBUNBLE_STRING_ENCODED));							// mainBundle
	SEL bundlePathSelector = NSSelectorFromString(NAppProtect__decodedString(ANTICRACK_BUNDLEPATH_STRING_ENCODED));							// bundlePath
	SEL executablePathSelector = NSSelectorFromString(NAppProtect__decodedString(ANTICRACK_EXECUTABLEPATH_STRING_ENCODED));					// executablePath
	SEL fileExistsAtPathSelector = NSSelectorFromString(NAppProtect__decodedString(ANTICRACK_FILEEXISTSATPATH_STRING_ENCODED));				// fileExistsAtPath:
	SEL attributesOfItemAtPathSelector = NSSelectorFromString(NAppProtect__decodedString(ANTICRACK_ATTRIBUTESOFITEMATPATH_STRING_ENCODED));	// attributesOfItemAtPath:error:
	SEL fileModificationDateSelector = NSSelectorFromString(NAppProtect__decodedString(ANTICRACK_FILEMODIFICATIONDATE_STRING_ENCODED));		// fileModificationDate
	
	NSString *codeResourcesString = NAppProtect__decodedString(ANTICRACK_CODERESOURCES_STRING_ENCODED);		// CodeResources
	NSString *codeSignatureString = NAppProtect__decodedString(ANTICRACK_CODESIGNATURE_STRING_ENCODED);		// _CodeSignature
	NSString *pkgInfoDirectoryString = NAppProtect__decodedString(ANTICRACK_PKGINFODIRECTORY_STRING_ENCODED);	// Resources/PkgInfo
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSBundle *mainBundle = [NSBundleClass performSelector:mainBundleSelector];
	NSString *bundlePath = [NSBundleClass instanceMethodForSelector:bundlePathSelector](mainBundle, bundlePathSelector);
	NSString *executablePath = [NSBundleClass instanceMethodForSelector:executablePathSelector](mainBundle, executablePathSelector);
    
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
	IMP fileExistsAtPathImplementation = [[NSFileManager class] instanceMethodForSelector:fileExistsAtPathSelector];
	BOOL codeResourcesExists = ((BOOL(*)(id, SEL, NSString *))fileExistsAtPathImplementation)(fileManager, fileExistsAtPathSelector, [bundlePath stringByAppendingPathComponent:codeResourcesString]);
	BOOL codeSignatureExists = ((BOOL(*)(id, SEL, NSString *))fileExistsAtPathImplementation)(fileManager, fileExistsAtPathSelector, [bundlePath stringByAppendingPathComponent:codeSignatureString]);
	
	suspect += (codeResourcesExists && codeSignatureExists) ? kAntiCrackNoCrackFound : kAntiCrackMissingCodeResourcesMask;
#else
#error Encoded strings are missing! Try running InfoScanner.
#endif
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	IMP fileModificationDateImplementation = [[NSDictionary class] instanceMethodForSelector:fileModificationDateSelector];
	IMP attributesOfItemAtPathImplementation = [[NSFileManager class] instanceMethodForSelector:attributesOfItemAtPathSelector];
	NSDate *executableModifiedDate = fileModificationDateImplementation(attributesOfItemAtPathImplementation(fileManager, attributesOfItemAtPathSelector, [bundlePath stringByAppendingPathComponent:executablePath], NULL), fileModificationDateSelector);
	NSDate *pkgInfoModifiedDate = fileModificationDateImplementation(attributesOfItemAtPathImplementation(fileManager, attributesOfItemAtPathSelector, [bundlePath stringByAppendingPathComponent:pkgInfoDirectoryString], NULL), fileModificationDateSelector);
	
	suspect += (fabs([executableModifiedDate timeIntervalSinceReferenceDate] - [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) < 60 * 60 * 24) ? kAntiCrackNoCrackFound : kAntiCrackModifiedExecutableFileMask;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
#if defined(ANTICRACK_SIGNERIDENTITY_STRING_ENCODED) && defined(ANTICRACK_SIGNERIDENTITY_STRING_ENCODED_HASH) && defined(ANTICRACK_SIGNERIDENTITY_STRING_DECODED_HASH)
	BOOL successSignerIdentityString = NO;
	NSString *signerIdentityString = NAppProtect__verifiedDecodedString(ANTICRACK_SIGNERIDENTITY_STRING_ENCODED, ANTICRACK_SIGNERIDENTITY_STRING_ENCODED_HASH, ANTICRACK_SIGNERIDENTITY_STRING_DECODED_HASH, &successSignerIdentityString);
    
	suspect += (successSignerIdentityString && [signerIdentityString isEqualToString:@"SignerIdentity"]) ? kAntiCrackNoCrackFound : kAntiCrackModifiedHoneyPotStringsMask;
#else
#error Encoded strings are missing! Try running InfoScanner.
#endif
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
	[pool drain];
	return suspect;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
#endif
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark -
#pragma mark Convenience
// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#define NAppProtect__isCracked() acicke()
static inline BOOL acicke() {
	return (cracked() == kAntiCrackNoCrackFound) ? NO : YES;
}

#define isLiteVersion() acilve()
static inline BOOL acilve() {
#ifdef LITE_VERSION
	return YES;
#else
	return (cracked() == kAntiCrackNoCrackFound) ? NO : YES;
#endif
}

#define isFullVersion() acifve()
static inline BOOL acifve() {
#ifdef LITE_VERSION
	return NO;
#else
	return (cracked() == kAntiCrackNoCrackFound) ? YES : NO;
#endif
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -