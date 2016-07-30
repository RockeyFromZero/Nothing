//
//  ADS.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/26.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADS : NSObject

/** 广告号 */
@property (nonatomic, copy) NSString *fnAid;
/** 内容 */
@property (nonatomic, copy) NSString *fnContent;
/** 商品ID号 */
@property (nonatomic, copy) NSString *fnId;
/** 展示的图片地址 */
@property (nonatomic, copy) NSString *fnImageUrl;
/** 订单数 */
@property (nonatomic, assign) NSInteger fnOrder;
/** 商品名 */
@property (nonatomic, copy) NSString *fnTitle;
/** 商品类型 */
@property (nonatomic, copy) NSString *fnType;
/** 商品的h5地址(只剩"df277edb-a0c6-43fb-919a-cf2a9ac7e952", 需要自己拼接) */
@property (nonatomic, copy) NSString *fnUrl;


@end
