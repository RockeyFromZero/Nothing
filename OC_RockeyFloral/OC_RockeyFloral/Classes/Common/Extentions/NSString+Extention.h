//
//  NSString+Extention.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - MD5
@interface NSString(MD5)

- (NSString *)stringToMd5;

@end

#pragma mark - DES
@interface NSString(DES)
/**
 *  字符串 转 Base64; 钥匙串 取默认
 *
 *  @return Base64
 */

- (NSString *)stringToBase64;
/**
 *  Base64 转 字符串; 钥匙串 取默认
 *
 *  @return 字符串
 */
- (NSString *)base64ToString;

/**
 *  字符串 转 Base64
 *
 *  @param key 钥匙
 *
 *  @return Base64
 */

- (NSString *)stringToBase64WithKey:(const NSString *)key;
/**
 *  Base64 转 字符串
 *
 *  @param key 钥匙
 *
 *  @return 字符串
 */
- (NSString *)base64ToStringWithKey:(const NSString *)key;

@end
