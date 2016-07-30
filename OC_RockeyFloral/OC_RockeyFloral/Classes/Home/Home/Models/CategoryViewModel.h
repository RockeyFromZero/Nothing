//
//  CategoryViewModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"

@interface CategoryViewModel : NSObject

@property (nonatomic, copy) NSArray *models;

+ (instancetype)viewModel:(void (^)(id))success failure:(void (^)(id))failure;
/**
 *  获取保存在本地 的数据
 *
 */
+ (NSArray *)unarchived;
/**
 *  删除序列化 数据
 */
+ (void)removeArchived;

@end
