//
//  Author.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/11.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : MTLModel <MTLJSONSerializing>

// 认证类型: 专家
@property (nonatomic, copy) NSString *auth;
// 所在城市
@property (nonatomic, copy) NSString *city;
// 简介
@property (nonatomic, copy) NSString *content;
// 是否订阅
@property (nonatomic, assign) NSUInteger dingYue;
// 头像
@property (nonatomic, copy) NSString *headImg;
//{
//    didSet{
//        if !headImg!.hasPrefix("http://") {
//            headImg = "http://static.htxq.net/" + headImg!
//        }
//    }
//}
// 用户id
@property (nonatomic, copy) NSString *ID;
// 标示: 官方认证
@property (nonatomic, copy) NSString *identity;
// 用户名
@property (nonatomic, copy) NSString *userName;
// 手机号18618234090
@property (nonatomic, copy) NSString *mobile;
// 订阅数
@property (nonatomic, assign) NSUInteger subscibeNum;
// 认证的等级, 1是yellow, 2是个人认证
@property (nonatomic, copy) NSString *authLevel;
//{
//    didSet{
//        switch newAuth {
//        case 1:
//            authImage = UIImage(named: "u_vip_yellow")
//        case 2:
//            authImage = UIImage(named: "personAuth")
//        default:
//            authImage = UIImage(named: "u_vip_blue")
//        }
//    }
//}
@property (nonatomic, strong) UIImage *authImage;
// 经验值
@property (nonatomic, assign) NSUInteger experience;
// 等级
@property (nonatomic, assign) NSUInteger level;
// 积分
@property (nonatomic, assign) NSUInteger integral;

@end
