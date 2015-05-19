//
//  FGMethodSwizzling.h
//  FGUserTrackerDemo
//
//  Created by wangzz on 15/5/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGMethodSwizzling : NSObject

+ (BOOL)swizzlingSelector:(SEL)originalSelector
                       to:(SEL)swizzledSelector
                     with:(Class)class;

@end
