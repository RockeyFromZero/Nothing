//
//  CommentCellModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface CommentCellModel : NSObject

/**  评论列表 */
@property (nonatomic, strong) NSMutableArray *comments;

/** 初始化 */
+ (instancetype)commentCellModel:(NSString *)ID
                         success:(void (^)(ErrorCode ErrorCode, NSString *error))success 
                         failure:(void (^)(void))failure;
- (void)getFirst;
- (void)getNext;

@end
