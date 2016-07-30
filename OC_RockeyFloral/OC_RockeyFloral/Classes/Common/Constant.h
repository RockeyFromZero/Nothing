//
//  Constant.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/29.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

typedef NS_ENUM(NSUInteger, ErrorCode) {
    ErrorCode_success,
    ErrorCode_fail,
    ErrorCode_NoMore,
    ErrorCode_Network
};

/** Top 10 类型 */
typedef NS_ENUM(NSInteger, TopType) {
    /** 专题 */
    TopType_artical,
    /** 作者 */
    TopType_author
};

/** 商城：精选(jingList/1) & 商城(theme) */
typedef NS_ENUM(NSInteger, MallIdentity) {
    /** 商城-精选 */
    MallsIdentity_jingxuan,
    /** 商城-Normal */
    MallsIdentity_theme
};

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
/** 导航栏高度 */
#define kNavigationBarHeight 64
/** TabBar 底部栏目高度 */
#define kTabBarItemHeight 49
/** 左右 Item Image width && Height */
#define kNavImageViewWH 20


/** window */
#define kWindow [UIApplication sharedApplication].keyWindow


#endif /* Constant_h */
