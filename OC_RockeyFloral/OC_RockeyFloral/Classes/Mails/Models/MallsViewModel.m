//
//  MallsViewModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#warning 精选 和 商城 使用 同一个 MallsViewModel 是不合理的；比如 先选择了 精选，在请求返回的同时，去选择商城，那么 精选的数据 很可能会被 放到商城里面
#warning 上面的问题 需要 在不同网络 环境中验证

#import "MallsViewModel.h"

@interface MallsViewModel ()

/** 精选 */
@property (nonatomic, strong) NSMutableArray *jingxunModels;
/** 商城 */
@property (nonatomic, copy) NSArray *themeModels;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL pageMinus;

@property (nonatomic, copy) void (^success)(ErrorCode, id);
@property (nonatomic, copy) void (^failure)(void);

@end

@implementation MallsViewModel

+ (instancetype)viewModel:(void (^)(ErrorCode, id))success failure:(void (^)(void))failure {
    return [[self alloc] init:success failure:failure];
}

- (instancetype)init:(void (^)(ErrorCode, id))success failure:(void (^)(void))failure {
    if (self = [super init]) {
        _success = success, _failure = failure;
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, pageIndex) ignore:@0] subscribeNext:^(id x) {
        if (!self.pageMinus) {
            if (MallType_jingxuan == self.mallType) {
                self.url = [NSString stringWithFormat:@"http://ec.htxq.net/rest/htxq/index/jingList/%@",x];
            } else {
                self.url = @"http://ec.htxq.net/rest/htxq/index/theme";
            }
        }
    }];
    [[RACObserve(self, mallType) skip:1] subscribeNext:^(NSNumber *x) {
        if (MallType_jingxuan == x.integerValue) {
            if (self.jingxunModels.count == 0) {
                self.pageMinus = NO;
                self.pageIndex = 1;
            }
        } else {
            self.url = @"http://ec.htxq.net/rest/htxq/index/theme";
        }
    }];
    [[RACObserve(self, url) ignore:nil] subscribeNext:^(id x) {
        [self getDataList];
    }];
}

- (void)getDataList {
    
    [[NetworkTool sharedTool] getAction:self.url paras:nil success:^(id success) {
        if (success[@"result"]) {
            self.pageMinus = NO;
            NSArray *result = success[@"result"];
            if (self.pageIndex <= 1) {
                [self.jingxunModels removeAllObjects];
            }
            
            if (MallType_jingxuan == self.mallType) {
                result = [Goods mj_objectArrayWithKeyValuesArray:result];
                [self.jingxunModels addObjectsFromArray:result];
                
                _success(ErrorCode_success,self.jingxunModels);
            } else {
                result = [MTLJSONAdapter modelsOfClass:[MallsGoods class] fromJSONArray:result error:nil];
                self.themeModels = [result copy];
                _success(ErrorCode_success,self.themeModels);
            }
            
        } else {
            [self currentPageIndexMinus];
            _success(ErrorCode_Network,nil);
        }
    } failure:^(id failure) {
        [self currentPageIndexMinus];
        _success(ErrorCode_Network,nil);
    }];
}

- (void)getFirst {
    self.pageMinus = NO;
    self.pageIndex = 1;
}
- (void)getNext {
    
    if (MallType_jingxuan == self.mallType) {
        self.pageMinus = NO;
        self.pageIndex++;
    } else {
        _success(ErrorCode_NoMore,nil);
    }
}

- (void)currentPageIndexMinus {
    self.pageMinus = YES;
    if (self.pageIndex > 1) {
        --self.pageIndex;
    }
}

#pragma mark - lazy load
- (NSMutableArray *)jingxunModels {
    if (!_jingxunModels) {
        _jingxunModels = [NSMutableArray array];
    }
    return _jingxunModels;
}
- (NSArray *)themeModels {
    if (!_themeModels) {
        _themeModels = [NSArray array];
    }
    return _themeModels;
}

@end
