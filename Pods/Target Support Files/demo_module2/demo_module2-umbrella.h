#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "demo_module2.h"
#import "XModuleImpModule2.h"
#import "XModuleImpModule2Ex.h"

FOUNDATION_EXPORT double demo_module2VersionNumber;
FOUNDATION_EXPORT const unsigned char demo_module2VersionString[];

