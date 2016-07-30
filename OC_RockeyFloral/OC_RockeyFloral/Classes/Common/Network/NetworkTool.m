//
//  NetworkTool.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "NetworkTool.h"

@interface NetworkTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation NetworkTool
static id sharedInstance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

+ (instancetype)sharedTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super init];
    });
    return sharedInstance;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10;
        _manager = manager;
    }
    return _manager;
}

- (void)getAction:(NSString *)url paras:(id)paras success:(void (^)(id))success failure:(void (^)(id))failure {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.manager GET:url parameters:paras success:^(NSURLSessionDataTask *task, id responseObject) {
            
            success(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failure(error);
        }];
    });
    
}

- (void)postAction:(NSString *)url paras:(id)paras success:(void (^)(id))success failure:(void (^)(id))failure {
    
    [self.manager POST:url parameters:paras success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
} 


@end
