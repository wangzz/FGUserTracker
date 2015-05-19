//
//  FGUserTrackerManager.h
//  FGUserTrackerDemo
//
//  Created by wangzz on 15/5/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGEvent : NSObject

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *controller;

@property (nonatomic, strong) NSMutableArray *selectorArray;

+ (instancetype)eventWithController:(NSString *)controller
                            address:(NSString *)address;


@end


@interface FGUserTrackerManager : NSObject

+ (instancetype)shareInstance;

- (BOOL)addAction:(SEL)action with:(id)target;

- (void)willPushViewController:(UIViewController *)controller;

- (void)willPopViewController;

- (NSString *)jsonString;

@end