//
//  UIApplication+UserTracker.m
//  FGUserTrackerDemo
//
//  Created by wangzz on 15/5/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "UIApplication+UserTracker.h"
#import "FGUserTrackerManager.h"
#import "FGMethodSwizzling.h"

@implementation UIApplication (UserTracker)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(sendAction:to:from:forEvent:);
        SEL swizzledSelector = @selector(heap_sendAction:to:from:forEvent:);
        [FGMethodSwizzling swizzlingSelector:originalSelector to:swizzledSelector with:class];
    });
}

- (BOOL)heap_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    NSString *selectorName = NSStringFromSelector(action);
    // Sometimes this method proxies through to its internal method. We want to ignore those calls.
    if (![selectorName isEqualToString:@"_sendAction:withEvent:"]) {
        [[FGUserTrackerManager shareInstance] addAction:action with:target];
        printf("%s Selector %s occurred.\n",[NSStringFromClass(self.class) UTF8String],[selectorName UTF8String]);
    }
    return [self heap_sendAction:action to:target from:sender forEvent:event];
}

@end
