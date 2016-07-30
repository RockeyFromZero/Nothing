//
//  Goods.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/26.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : MTLModel<MTLJSONSerializing>

/** 1：推荐；2、最热 */
@property (nonatomic, assign) NSInteger fnJian;
/** 推荐/最热的图片 */
@property (nonatomic, strong) UIImage *fnjianIcon;
/** 推荐/最热的文字 */
@property (nonatomic, copy) NSString *fnjianTitle;
/** 图片地址 */
@property (nonatomic, copy) NSString *fnAttachment;
/** 缩略图 */
@property (nonatomic, copy) NSString *fnAttachmentSnap;
/** 价格 */
@property (nonatomic, assign) CGFloat fnMarketPrice;
/** 类型(暂且理解为是类型) */
@property (nonatomic, copy) NSString *fnEnName;
/** 商品名字 */
@property (nonatomic, copy) NSString *fnName;
/** 商品ID */
@property (nonatomic, copy) NSString *fnId;


@end

/// 1是推荐  2是最热
var fnJian : Int = 0
{
    didSet{
        if fnJian == 2 {
            fnjianIcon = UIImage(named: "f_hot_56x51")
            fnjianTitle = "最热"
        }else{
            fnjianIcon = UIImage(named: "f_jian_56x51")
            fnjianTitle = "推荐"
        }
    }
}

/// 默认收货地址
//var uAddress : Address?

