//
//  Category.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/29.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "Category.h"

@implementation RCategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"createDate":@"createDate",
             @"ID":@"id",
             @"name":@"name",
             @"order":@"order"};
}

+ (NSValueTransformer *)IDJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return value;
    }];
}
+ (NSValueTransformer *)createDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        if ([value containsString:@".0"]) {
            value = [value stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        return value;
    }];
}

@end
