//
//  UserInfo.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/13.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject

@property (nonatomic, strong) Author *author;
+ (instancetype)sharedInstance;

@end
