//
//  FGUserTrackerManager.m
//  FGUserTrackerDemo
//
//  Created by wangzz on 15/5/19.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGUserTrackerManager.h"

@implementation FGEvent

+ (instancetype)eventWithController:(NSString *)controller
                            address:(NSString *)address {
    return [[self alloc] initWithController:controller address:address];
}

- (instancetype)initWithController:(NSString *)controller
                           address:(NSString *)address {
    if (self = [super init]) {
        _controller = [controller copy];
        _address = [address copy];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@ %@",self.address,self.controller,self.selectorArray];
}

@end



@interface FGUserTrackerManager ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation FGUserTrackerManager

+ (instancetype)shareInstance {
    static FGUserTrackerManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FGUserTrackerManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [NSMutableArray array];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}

- (BOOL)addAction:(SEL)action with:(id)target {
    if (![target isKindOfClass:[NSObject class]]) {
        return NO;
    }
    NSObject *targetObject = (NSObject *)target;
    
    FGEvent *event = self.dataArray.lastObject;
    if (![event isKindOfClass:[FGEvent class]]) {
        return NO;
    }
    
    if (event.selectorArray == nil) {
        event.selectorArray = [NSMutableArray array];
    }
    
    NSString *selectorString = NSStringFromSelector(action);
    NSString *targetString = NSStringFromClass(targetObject.class);
    NSString *dateString = [self.dateFormatter stringFromDate:[NSDate date]];
    NSString *actionString = [NSString stringWithFormat:@"%@#%@#%@",dateString,targetString,selectorString];
    [event.selectorArray addObject:actionString];
    
    return YES;
}

- (void)willPushViewController:(UIViewController *)controller {
    [self.dataArray addObject:[FGEvent eventWithController:NSStringFromClass(controller.class)
                                                   address:[NSString stringWithFormat:@"%p",controller]]];
}

- (void)willPopViewController {
}

- (NSString *)jsonString
{
    NSLog(@"%@",self.dataArray);
    return nil;
}

@end
