//
//  HomeViewModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/5.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel ()

@property (nonatomic, copy) void (^success)(id);
@property (nonatomic, copy) void (^failure)(id);

/** models 在 列表刷新的时候 是变化的 不能作为 Home主题列表数据 */
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic) NSUInteger currentPage;

@end

@implementation HomeViewModel
/** currentPage 进行了 减法操作；获取数据失败 或者 已经没数据了 */
static void *pageMinusKey = "pageMinusKey";
/** get data success */
static void *kGetDataSuccess = @"HomeVM_GetDataSuccess";

+ (instancetype)viewModel:(void (^)(id))success failure:(void (^)(id))failure {
    return [[self alloc] init:success failure:failure];
}

- (instancetype)init:(void (^)(id))success failure:(void (^)(id))failure {
    if (self = [super init]) {
        _success = success; _failure = failure;
        [self bindModel];
        objc_setAssociatedObject(self, &pageMinusKey, @0, OBJC_ASSOCIATION_ASSIGN);
    }
    return self;
}

- (void)bindModel {
    
    [RACObserve(self, currentPage) subscribeNext:^(id x) {
        if ([@0 isEqual:objc_getAssociatedObject(self, &pageMinusKey)]) {
            [self getDatas];
        }
    }];
}

- (void)getDatas {
    NSDictionary *paras = @{@"currentPageIndex":[NSString stringWithFormat:@"%lu",(unsigned long)_currentPage], @"pageSize":@"5"};
    [[NetworkTool sharedTool] postAction:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList" paras:paras success:^(NSDictionary *success) {
        if ([success[@"status"] isEqual:@1]) {
            
            if (!_models) {
                _models = [NSMutableArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[Artical class] fromJSONArray:success[@"result"] error:nil]];
            } else {
                [_models addObjectsFromArray:[[MTLJSONAdapter modelsOfClass:[Artical class] fromJSONArray:success[@"result"] error:nil] copy]];
            }
            objc_setAssociatedObject(self, &kGetDataSuccess, @1, OBJC_ASSOCIATION_ASSIGN);
            _success(_models);
        } else {
            [self currentPageMinus];
            _success(_models);
        }
        
    } failure:^(id failure) {
        [self currentPageMinus];
        _failure(failure);
    }];
}

- (void)currentPageMinus {
    if (self.currentPage > 0) {
        objc_setAssociatedObject(self, &pageMinusKey, @1, OBJC_ASSOCIATION_ASSIGN);
        self.currentPage--;
    }
}

- (void)getNext {
    if ([objc_getAssociatedObject(self, &kGetDataSuccess) isEqual:@1]) {
        self.currentPage++;
        objc_setAssociatedObject(self, &kGetDataSuccess, @0, OBJC_ASSOCIATION_ASSIGN);
    } else {
        [self getDatas];
    }
}
- (void)getFirst {
    objc_setAssociatedObject(self, &kGetDataSuccess, @0, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &pageMinusKey, @0, OBJC_ASSOCIATION_ASSIGN);
    [self.models removeAllObjects];
    self.currentPage = 0;
}

@end
