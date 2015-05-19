//
//  UIViewController+UserTracker.m
//  FGUserTrackerDemo
//
//  Created by wangzz on 15/5/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "UIViewController+UserTracker.h"
#import "FGUserTrackerManager.h"
#import "FGMethodSwizzling.h"

@implementation UIViewController (UserTracker)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector1 = @selector(viewWillAppear:);
        SEL swizzledSelector1 = @selector(fg_viewWillAppear:);
        [FGMethodSwizzling swizzlingSelector:originalSelector1 to:swizzledSelector1 with:[self class]];
        
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(fg_viewWillDisappear:);
        [FGMethodSwizzling swizzlingSelector:originalSelector2 to:swizzledSelector2 with:[self class]];
    });
}

-(void)fg_viewWillAppear:(BOOL)animated {
    [[FGUserTrackerManager shareInstance] willPushViewController:self];
    [self fg_viewWillAppear:animated];
}

-(void)fg_viewWillDisappear:(BOOL)animated {
    [[FGUserTrackerManager shareInstance] willPopViewController];
    [self fg_viewWillDisappear:animated];
}

@end
