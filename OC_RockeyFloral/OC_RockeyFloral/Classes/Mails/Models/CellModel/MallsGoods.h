//
//  MallsGoods.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/26.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface MallsGoods : MTLModel<MTLJSONSerializing>

/** 分类描述信息 */
@property (nonatomic, copy) NSString *fnDesc;
/** 分类id */
@property (nonatomic, copy) NSString *fnId;
/** 分类的 */
@property (nonatomic, copy) NSString *fnName;
/** 商品列表 */
@property (nonatomic, copy) NSArray *goodsList;

@end