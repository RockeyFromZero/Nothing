//
//  ProfileArticalVM.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/12.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileArticalVM : NSObject

/** Nothing: 原本 想作为 vm 返回字符串处理 */
@property (nonatomic, copy) NSArray *articalList;

+ (instancetype)profileArticalVM:(void (^)(ErrorCode, id))success;
- (void)getFirst;
- (void)getNext;

@end
