//
//  Artical.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/5.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "Artical.h"
#import "NSDate+Extention.h"


@implementation Artical
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"createDate":@"createDate",
             @"createDateDesc":@"createDateDesc",
             @"desc":@"desc",
             @"fnCommentNum":@"fnCommentNum",
             @"favo":@"favo",
             @"ID":@"id",
             @"order":@"order",
             @"pageUrl":@"pageUrl",
             @"read":@"read",
             @"share":@"share",
             @"sharePageUrl":@"sharePageUrl",
             @"smallIcon":@"smallIcon",
             @"title":@"title",
             @"isNotHomeList":@"isNotHomeList",
             @"author":@"author",
             @"category":@"category",
             };
}

+ (NSValueTransformer *)createDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value containsString:@".0"]) {
            value = [value stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        return value;
    }];
}
+ (NSValueTransformer *)authorJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        id obj = [MTLJSONAdapter modelOfClass:[Author class] fromJSONDictionary:value error:nil];
        return obj;
    }];
}
+ (NSValueTransformer *)categoryJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:[RCategory class] fromJSONDictionary:value error:nil];
    }];
}
- (void)setCreateDate:(NSString *)createDate {
    _createDate = createDate;
    _createDateDesc = [[NSDate dateWithString:createDate] dateDesc];
}

@end
