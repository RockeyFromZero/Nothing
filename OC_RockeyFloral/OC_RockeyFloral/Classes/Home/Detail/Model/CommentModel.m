//
//  CommentModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"bbsId":@"bbsId",
             @"content":@"content",
             @"ID":@"id",
             @"toUser":@"toUser",
             @"writer":@"writer",
             
             @"createDate":@"createDate",
             @"createDateDesc":@"createDateDesc",
             @"anonymous":@"anonymous",
             @"rowHeight":@"rowHeight",
             @"contentFont":@"contentFont"
             };
}

+ (NSValueTransformer *)toUserJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:[Author class] fromJSONDictionary:value error:nil];
    }];
}
+ (NSValueTransformer *)writerJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *value, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:[Author class] fromJSONDictionary:value error:nil];
    }];
}
- (void)setWriter:(Author *)writer {
    _writer = writer;
    _anonymous = writer.userName.length == 0;
}
- (void)setContent:(NSString *)content {
    _content = content;
    _contentFont = [UIFont systemFontOfSize:12];
    
    CGFloat contentW = kScreenWidth - kDefaultMargin15 - kDefaultMargin20 - kDefaultHeadHeight;
    CGFloat contentHeight = [content boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_contentFont} context:nil].size.height;
    
    _rowHeight = kDefaultMargin10 + kDefaultHeadHeight  + contentHeight + kDefaultMargin10 + 30 + kDefaultMargin10;
}
- (void)setCreateDate:(NSString *)createDate {
    _createDate = createDate;
    if ([_createDate containsString:@".0"]) {
        _createDate = [_createDate stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _createDateDesc = [NSDate dateWithString:_createDate].dateDesc;
}

@end
