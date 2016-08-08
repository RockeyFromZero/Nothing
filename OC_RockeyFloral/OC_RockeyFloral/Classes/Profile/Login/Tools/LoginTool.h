//
//  LoginTool.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginTool : NSObject

+ (instancetype)shareInstance;

- (void)setLoginStatus:(BOOL)status;
- (BOOL)isLogin;

@end
