//
//  Goods.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/26.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "Goods.h"

@implementation Goods

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"fnJian":@"fnJian",
             @"fnjianIcon":@"fnjianIcon",
             @"fnjianTitle":@"fnjianTitle",
             @"fnAttachment":@"fnAttachment",
             @"fnAttachmentSnap":@"fnAttachmentSnap",
             @"fnMarketPrice":@"fnMarketPrice",
             @"fnEnName":@"fnEnName",
             @"fnName":@"fnName",
             @"fnId":@"fnId"
             };
}

- (void)setFnJian:(NSInteger)fnJian {
    if (1 == fnJian) {
        _fnjianIcon = [UIImage imageNamed:@"f_jian_56x51"];
        _fnjianTitle = @"推荐";
    } else {
        _fnjianIcon = [UIImage imageNamed:@"f_hot_56x51"];
        _fnjianTitle = @"最热";
    }
}


@end
