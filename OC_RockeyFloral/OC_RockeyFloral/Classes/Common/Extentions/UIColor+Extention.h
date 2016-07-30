//
//  UIColor+Extention.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/29.
//  Copyright © 2016年 Rockey. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(Extention)

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSArray *)RGBWithHexString:(NSString *)stringToConvert;

@end
