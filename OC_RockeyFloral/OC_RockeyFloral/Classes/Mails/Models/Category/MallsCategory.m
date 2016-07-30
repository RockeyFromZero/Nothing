//
//  MallsCategory.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsCategory.h"

@implementation MallsCategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fnId":@"fnId",
             @"fnPid":@"fnPid",
             @"fnName":@"fnName",
             @"fnDesc":@"fnDesc",
             @"childrenList":@"childrenList"
             };
}
+ (NSValueTransformer *)childrenListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *array, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[MallsCategory class] fromJSONArray:array error:nil];
    }];
}
+ (NSValueTransformer *)fnDescJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id obj, BOOL *success, NSError *__autoreleasing *error) {
        return obj ? : @"";
    }];
}

@end
