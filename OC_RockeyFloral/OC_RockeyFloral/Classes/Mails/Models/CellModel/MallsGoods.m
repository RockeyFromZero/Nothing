//
//  MallsGoods.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/26.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsGoods.h"

@implementation MallsGoods
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fnDesc":@"fnDesc",
             @"fnId":@"fnId",
             @"fnName":@"fnName",
             @"goodsList":@"goodsList"
             };
}

+ (NSValueTransformer *)goodsListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelsOfClass:[Goods class] fromJSONArray:value error:nil];
    }];
}

@end
