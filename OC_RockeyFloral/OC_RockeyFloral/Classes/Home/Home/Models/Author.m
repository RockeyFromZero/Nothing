//
//  Author.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/11.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "Author.h"

@implementation Author

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"auth":@"auth",
             @"city":@"city",
             @"content":@"content",
             @"dingYue":@"dingYue",
             @"headImg":@"headImg",
             @"ID":@"id",
             @"identity":@"identity",
             @"userName":@"userName",
             @"mobile":@"mobile",
             @"subscibeNum":@"subscibeNum",
             @"authLevel":@"newAuth",
             @"authImage":@"authImage",
             @"experience":@"experience",
             @"level":@"level",
             @"integral":@"integral",
             };

}

+ (NSValueTransformer *)headImgJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        if (![value hasPrefix:@"http://"]) {
            value = [NSString stringWithFormat:@"http://static.htxq.net/%@",value];
        }
        return value;
    }];
}
- (void)setAuthLevel:(NSString *)authLevel {
    NSInteger level = authLevel.integerValue;
    switch (level) {
        case 1:
            _authImage = [UIImage imageNamed:@"u_vip_yellow"];
            break;
        case 2:
            _authImage = [UIImage imageNamed:@"personAuth"];
            break;
            
        default:
            _authImage = [UIImage imageNamed:@"u_vip_blue"];
            break;
    }
}


@end
