//
//  TopViewModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/20.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopViewModel.h"

@interface TopViewModel ()

@property (nonatomic, copy) void (^success)(ErrorCode, NSString *);
@property (nonatomic, copy) void (^failure)(void);

@property (nonatomic, assign) BOOL articalFirst;
@property (nonatomic, assign) BOOL authorFirst;

@end

@implementation TopViewModel
+ (instancetype)viewModelSuccess:(void (^)(ErrorCode, NSString *))success
                      failure:(void (^)(void))failure {
    return [[super alloc] initWithSuccess:success failure:failure];
}
- (instancetype)initWithSuccess:(void (^)(ErrorCode, NSString *))success
                 failure:(void (^)(void))failure {
    if (self = [super init]) {
        _success = success; _failure = failure;
        _topAuthors = [NSMutableArray array];
        _topAritcals = [NSMutableArray array];
        
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [RACObserve(self, actionType) subscribeNext:^(NSNumber *x) {
        [self getDatas:x.integerValue];
    }];
}

- (void)getDatas:(TopType)topType {
    
    if ((TopType_artical == topType && _topAritcals.count && _articalFirst) ||
        (TopType_author == topType && _topAuthors.count && _articalFirst)) {
        _success(ErrorCode_success,nil);
        return;
    }
    
    NSString *action = TopType_artical == topType ?  @"topContents" : @"topArticleAuthor";
    [[NetworkTool sharedTool] getAction:@"http://ec.htxq.net/servlet/SysArticleServlet?currentPageIndex=0&pageSize=10" paras:@{@"action":action} success:^(id success) {
        if (success) {
            NSArray *result = success[@"result"];
            if (TopType_artical == topType) {
                [self resetArticalFirst:YES];
                [_topAritcals addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[Artical class] fromJSONArray:result error:nil]];
            } else {
                [self resetArticalFirst:NO];
                [_topAuthors addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[Author class] fromJSONArray:result error:nil]];
            }
            _success(ErrorCode_success,nil);
        } else {
            _success(ErrorCode_Network,nil);
        }
    } failure:^(id failure) {
        _failure();
    }];
}

- (void)resetArticalFirst:(BOOL)b {
    NSInteger delay = 10*60;
    if (b) {
        _articalFirst = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _articalFirst = NO;
        });
    } else {
        _authorFirst = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            _authorFirst = NO;
        });
    }
}

@end
