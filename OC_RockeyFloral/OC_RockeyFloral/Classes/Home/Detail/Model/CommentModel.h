//
//  CommentModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

/** 头像高度 */
static CGFloat kDefaultHeadHeight  = 51.0;
// 默认15间距
static CGFloat kDefaultMargin15  = 15.0;
// 默认10间距
static CGFloat kDefaultMargin10 = 10.0;
// 默认20间距
static CGFloat kDefaultMargin20 = 20.0;

@interface CommentModel : MTLModel<MTLJSONSerializing>
/**  评论的文章的id */
@property (nonatomic, copy)  NSString *bbsId;
/**  评论的内容 */
@property (nonatomic, copy)  NSString *content;
/**  评论的id */
@property (nonatomic, copy)  NSString *ID;
/**  回复的是谁, 显示 @XXXX */
@property (nonatomic, strong)  Author *toUser;
/**  回复人 */
@property (nonatomic, strong)  Author *writer;
/**  评论时间 */
@property (nonatomic, copy)  NSString *createDate;
/**  转换后的时间 */
@property (nonatomic, copy)  NSString *createDateDesc;
/**  是否是匿名评论 */
@property (nonatomic, assign) BOOL anonymous;
/**  行高 */
@property (nonatomic, assign) CGFloat rowHeight;
/** content font */
@property (nonatomic, strong) UIFont *contentFont;





@end
