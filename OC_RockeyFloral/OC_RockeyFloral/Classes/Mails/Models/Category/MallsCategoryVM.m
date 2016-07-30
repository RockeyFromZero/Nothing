//
//  MallsCategoryVM.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsCategoryVM.h"

@interface MallsCategoryVM ()

@property (nonatomic, copy) void (^complete)(ErrorCode, id);
@property (nonatomic, copy) void (^failure)(ErrorCode, id);

@end

@implementation MallsCategoryVM
+ (instancetype)mallsCategoryComplete:(void (^)(ErrorCode, id))complete 
                              failure:(void (^)(ErrorCode, id))failure {
    return [[super alloc] initWithComplete:complete failure:failure];
}
- (instancetype)initWithComplete:(void (^)(ErrorCode, id))complete
                         failure:(void (^)(ErrorCode, id))failure {
    if (self = [super init]) {
        _complete = complete, _failure = failure;
        self.categorys = [NSArray array];
        [self getDatas];
    }
    return self;
}

- (void)getDatas {
    [[NetworkTool sharedTool] getAction:@"http://ec.htxq.net/rest/htxq/item/tree" paras:nil success:^(id success) {
        if (success && success[@"result"]) {
            
            self.categorys = [MTLJSONAdapter modelsOfClass:[MallsCategory class] fromJSONArray:success[@"result"] error:nil];
            _complete(ErrorCode_success,nil);
        }
    } failure:^(id failure) {
        if (_failure) {
            _failure(ErrorCode_Network,nil);
        }
    }];
}


@end
