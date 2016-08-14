//
//  Constant.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/29.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

/** Top 10 类型 */
typedef NS_ENUM(NSInteger, TopType) {
    /** 专题 */
    TopType_artical,
    /** 作者 */
    TopType_author
};

/** 商城：精选(jingList/1) & 商城(theme) */
typedef NS_ENUM(NSInteger, MallType) {
    /** 商城-精选 */
    MallType_jingxuan,
    /** 商城-Normal */
    MallType_theme
};

/** LoginType */
typedef NS_ENUM(NSInteger, LoginType) {
    LoginType_login = 1,
    LoginType_regist,
    LoginType_forgetPwd
};



/********* ********* ********* noti ********* ********* *********/
#define kToLocalController @"kToLocalController"
#define kLocalDidSelected @"kLocalDidSelected"



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
