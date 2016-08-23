//
//  NSDate+Extention.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "NSDate+Extention.h"

@implementation NSDate(Extention)

+ (NSDate *)dateWithString:(NSString *)string {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 有的时候, 有的服务器生成的时间是采用的其他地区或者语音,这种情况, 一定要设置本地化, 比如这儿的Aug, 如果你不设置成en, 那么鬼才知道你要解析成什么样的.
    //        formatter.locale = NSLocale(localeIdentifier: "en")
    return [formatter dateFromString:string];
}


- (NSString *)dateDesc {

    
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSString *formatterStr = @"";
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([calendar isDateInToday:self]){
        NSInteger seconds = [[NSDate new] timeIntervalSinceDate:self];
        if (seconds < 60){
            return @"刚刚";
        }else if (seconds < 60 * 60){
            return [NSString stringWithFormat:@"%ld分钟前",(long)(seconds/60)];
        }else{
            return [NSString stringWithFormat:@"%ld小时前",(long)(seconds/60/60)];
        }
    }else if ([calendar isDateInYesterday:self]) {
        // 昨天: 昨天 17:xx
        formatterStr = @"昨天 HH:mm";
    }else{
        
        // 很多年前: 2014-12-14 17:xx
        // 如果枚举可以选择多个, 就用数组[]包起来, 如果为空, 就直接一个空数组
        NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self toDate:[NSDate new] options:NSCalendarWrapComponents];
        // 今年: 03-15 17:xx
        if (components.year < 1)
        {
            formatterStr = @"MM-dd HH:mm";
        }else{
            formatterStr = @"yyyy-MM-dd HH:mm";
        }
    }
    formatter.dateFormat = formatterStr;
    
    return [formatter stringFromDate:self];
}

@end
