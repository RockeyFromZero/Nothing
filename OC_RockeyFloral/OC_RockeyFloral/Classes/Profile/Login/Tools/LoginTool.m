//
//  LoginTool.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "LoginTool.h"

@interface LoginTool ()

@property (nonatomic) BOOL bLoginStatus;

@end

@implementation LoginTool
static LoginTool *instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    /** 也可以直接返回 [LoginTool shareInstance]；但是方法的调用 还是要多调用堆栈，就多写几行代码了 */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}

+ (BOOL)isLogin {
    return [LoginTool shareInstance].bLoginStatus;
}
+ (void)setLoginStatus:(BOOL)status {
    [LoginTool shareInstance].bLoginStatus = status;
}

@end
