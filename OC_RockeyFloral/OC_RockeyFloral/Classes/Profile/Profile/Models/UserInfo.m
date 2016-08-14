//
//  UserInfo.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/13.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
static UserInfo *kSharedInstance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSharedInstance = [super allocWithZone:zone];
    });
    return kSharedInstance;
}
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSharedInstance = [[self alloc] init];
    });
    return kSharedInstance;
}
- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSharedInstance = [super init];
    });
    return kSharedInstance;
}


@end
