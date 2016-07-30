//
//  CategoryViewModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CategoryViewModel.h"

static NSString* kCategoryLocalPath = @"kCategoryPath";

#define kCategoryFullPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
                                        NSUserDomainMask, YES).firstObject stringByAppendingString: \
                                        (kCategoryLocalPath)]
@interface CategoryViewModel ()

@property (nonatomic, copy) void (^success)(id);
@property (nonatomic, copy) void (^failure)(id);

@end

@implementation CategoryViewModel
+ (instancetype)viewModel:(void (^)(id))success failure:(void (^)(id))failure {
    return [[self alloc] init:success failure:failure];
}

- (instancetype)init:(void (^)(id))success failure:(void (^)(id))failure {
    if (self = [super init]) {
        _success = success; _failure = failure;
        [self getDatas];
    }
    return self;
}


- (instancetype)init {
    if (self = [super init]) {
        [self getDatas];
    }
    return self;
}

- (void)getDatas {
    
    [[NetworkTool sharedTool] getAction:@"http://m.htxq.net/servlet/SysCategoryServlet?action=getList" paras:nil success:^(NSDictionary *success) {
        if ([success[@"status"] isEqual:@1]) {
            
            _models = [MTLJSONAdapter modelsOfClass:[RCategory class] fromJSONArray:success[@"result"] error:nil];
            /** 序列化 */
            [NSKeyedArchiver archiveRootObject:_models toFile:kCategoryFullPath];
            
            _success(_models);
        } 
        
    } failure:^(id failure) {
        
        _failure(failure);
    }];
}

+ (NSArray *)unarchived {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kCategoryFullPath];
}
+ (void)removeArchived {
    if ([[NSFileManager defaultManager] fileExistsAtPath:kCategoryLocalPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:kCategoryLocalPath error:nil];
    }
}

@end
