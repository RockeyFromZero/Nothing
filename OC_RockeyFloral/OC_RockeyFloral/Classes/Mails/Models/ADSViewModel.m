//
//  ADSViewModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ADSViewModel.h"

@interface ADSViewModel ()

@property (nonatomic, copy) void (^response)(ErrorCode, id);

@end

@implementation ADSViewModel
+ (instancetype)ADSViewModel:(void (^)(ErrorCode, id))response {
    return [[self alloc] init:response];
}

- (instancetype)init:(void (^)(ErrorCode, id))response {
    if (self = [super init]) {
        _response = response;
        [self getDatas];
    }
    return self;
}

- (void)getDatas {
    
    [[NetworkTool sharedTool] getAction:@"http://ec.htxq.net/rest/htxq/index/carousel" paras:nil success:^(NSDictionary *success) {
        
        if (success && [success[@"status"] isEqual:@1] && success[@"result"]) {
            ADS *model = [ADS mj_objectWithKeyValues:((NSArray *)success[@"result"])[0]];
            _response(ErrorCode_success, model);
        } else {
            _response(ErrorCode_Network,success[@"msg"]);
        }
    } failure:^(id failure) {
        _response(ErrorCode_Network,nil);
    }];
}

- (void)refresh {
    [self getDatas];
}

@end
