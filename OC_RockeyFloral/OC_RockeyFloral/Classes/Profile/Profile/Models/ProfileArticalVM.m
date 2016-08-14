//
//  ProfileArticalVM.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/12.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ProfileArticalVM.h"

@interface ProfileArticalVM ()

@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, assign) BOOL pageIndexMinus;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, copy) void (^success)(ErrorCode, id);

@end

@implementation ProfileArticalVM
+ (instancetype)profileArticalVM:(void (^)(ErrorCode, id))success {
    return [[self alloc] init:success];
}
- (instancetype)init:(void (^)(ErrorCode, id))success {
    if (self = [super init]) {
        _success = success;
        _dataList = [NSMutableArray array];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [RACObserve(self, pageIndex) subscribeNext:^(id x) {
        if (!_pageIndexMinus) {
            [self getDatas];
        }
    }];
}

- (void)getDatas {
    NSString *url = @"http://m.htxq.net/servlet/UserCenterServlet?action=getMyContents&pageSize=20";
    [[NetworkTool sharedTool] getAction:url paras:@{@"currentPageIndex":@(self.pageIndex), @"userId":[UserInfo sharedInstance].author.ID} success:^(NSDictionary *success) {
        if ([success[@"status"] isEqual:@(true)]) {
            if ([success[@"msg"] isEqual:@"已经到最后"]) {
                _success(ErrorCode_NoMore,kErrorCodeNomore);
            } else {
               [self.dataList addObjectsFromArray:[MTLJSONAdapter modelsOfClass:[Artical class] fromJSONArray:success[@"result"] error:nil]];
                _success(ErrorCode_success,self.dataList);
            }
        } else {
            _success(ErrorCode_Network,kErrorCodeNetwork);
        }
    } failure:^(id failure) {
        _success(ErrorCode_Network,kErrorCodeNetwork);
    }];
}

- (void)getFirst {
    self.pageIndex = 0;
    self.pageIndexMinus = NO; 
    [self.dataList removeAllObjects];
}
- (void)getNext {
    self.pageIndexMinus = NO;
    self.pageIndex++;
}
- (void)currentIndexMinus {
    if (self.pageIndex > 0) {
        self.pageIndexMinus = YES;
        self.pageIndex--;
    }
    
}

@end
