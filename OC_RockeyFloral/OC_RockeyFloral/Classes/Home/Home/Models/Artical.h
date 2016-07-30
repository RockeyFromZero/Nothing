//
//  Artical.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/5.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Category.h"

@interface Artical : MTLModel <MTLJSONSerializing>
/** 创建时间 */
@property (nonatomic, copy) NSString *createDate;
/** 时间描述：昨天-今天-去年。。。 */
@property (nonatomic, copy) NSString *createDateDesc;
// 摘要
@property (nonatomic, copy) NSString *desc;
// 评论数
@property (nonatomic, assign) NSInteger fnCommentNum;
// 点赞数
@property (nonatomic, assign) NSInteger favo;
// 文章ID
@property (nonatomic, copy) NSString *ID;
// 序号
@property (nonatomic, assign) NSInteger order;
// 文章的H5地址
@property (nonatomic, copy) NSString *pageUrl;
// 阅读数
@property (nonatomic, assign) NSInteger read;
// 分享数
@property (nonatomic, assign) NSInteger share;
// 用户分享的URL
@property (nonatomic, copy) NSString *sharePageUrl;
// 缩略图
@property (nonatomic, copy) NSString *smallIcon;
// 文章标题
@property (nonatomic, copy) NSString *title;
// 是否是首页的, 如果是首页不显示时间
@property (nonatomic, assign) BOOL isNotHomeList;


// 作者
@property (nonatomic, strong) Author *author;
// 所属分类
@property (nonatomic, strong) RCategory *category;

@end
