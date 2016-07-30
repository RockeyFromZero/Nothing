//
//  ShareVM.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ShareVM.h"

@implementation ShareVM

- (instancetype)init {
    if (self = [super init]) {
        _installedApi = [NSMutableArray array];
        [self setupArray];
    }
    return self;
}

- (void)setupArray {

    if ([WXApi isWXAppInstalled]) {
        [_installedApi addObject:@{kShareVMPlatform:@"wechat",@"image":[UIImage imageNamed:@"s_weixin_50x50"]}];
    }
    
}

@end
