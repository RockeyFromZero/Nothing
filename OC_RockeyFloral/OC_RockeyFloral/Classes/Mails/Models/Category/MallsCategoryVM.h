//
//  MallsCategoryVM.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallsCategory.h"

@interface MallsCategoryVM : NSObject

@property (nonatomic, copy) NSArray *categorys;

+ (instancetype)mallsCategoryComplete:(void (^)(ErrorCode, id))complete 
                              failure:(void(^)(ErrorCode, id))failure;

@end
