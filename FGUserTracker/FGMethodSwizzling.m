//
//  FGMethodSwizzling.m
//  FGUserTrackerDemo
//
//  Created by wangzz on 15/5/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGMethodSwizzling.h"
#import <objc/runtime.h>

@implementation FGMethodSwizzling

+ (BOOL)swizzlingSelector:(SEL)originalSelector to:(SEL)swizzledSelector with:(Class)class {
    // This implementation of swizzling was lifted from http://nshipster.com/method-swizzling
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return YES;
}


@end
