
//
//  CommentCellModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CommentCellModel.h"

@interface CommentCellModel ()

@property (nonatomic, copy) void (^success)(ErrorCode errorCode, NSString *error);
@property (nonatomic, copy) void (^failure)(void);


/** 评论ID */
@property (nonatomic, copy)  NSString *bbsID;
/** 页码 */
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL currentPageMinus;

@end

@implementation CommentCellModel

+ (instancetype)commentCellModel:(NSString *)ID 
                         success:(void (^)(ErrorCode errorCode, NSString *error))success 
                         failure:(void (^)(void))failure {
    return [[self alloc] initWithId:ID success:success failure:failure];
}
- (instancetype)initWithId:(NSString *)Id 
                   success:(void (^)(ErrorCode errorCode, NSString *error))success
                   failure:(void (^)(void))failure {
    if (self = [super init]) {
        _bbsID = Id;
        _success = success;
        _failure = failure;
        _comments = [NSMutableArray array];

        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [RACObserve(self, currentPage) subscribeNext:^(id x) {
        if (self.currentPageMinus == NO) {
            [self getDatas];
        }
    }];
}

- (void)getFirst {
    [self.comments removeAllObjects];
    self.currentPageMinus = NO;
    self.currentPage = 0;
}
- (void)getNext {
    self.currentPageMinus = NO;
    self.currentPage++;
}

- (void)getDatas {
    NSDictionary *paras = @{@"action":@"getList", @"bbsId":_bbsID, 
                            @"currentPageIndex":[NSString stringWithFormat:@"%ld",(long)_currentPage],
                            @"pageSize":@"10"};
    [[NetworkTool sharedTool] postAction:@"http://m.htxq.net/servlet/UserCommentServlet" paras:paras success:^(NSDictionary *success) {
        
        if ([success[@"msg"] isEqualToString:@"还没有发布任何评论。"]) {
            
            [self minusCurrentPage];
            _success(ErrorCode_NoMore,@"没有更多数据");
            
        } else {
            
            NSArray *result = success[@"result"];
            if (result) {
                
                NSArray *comments = [MTLJSONAdapter modelsOfClass:[CommentModel class] fromJSONArray:result error:nil];
                [self.comments addObjectsFromArray:comments];
                self.currentPageMinus = NO;
                _success(ErrorCode_success, @"");
            } else {
                
                 [self minusCurrentPage];
                _success(ErrorCode_fail, @"服务器异常");
            }
        }
    } failure:^(id failure) {
        [self minusCurrentPage];
        _failure();
    }];
}
- (void)minusCurrentPage {
    if (self.currentPage > 0) {
        self.currentPageMinus = YES;
        self.currentPage--;
    }
}

@end
