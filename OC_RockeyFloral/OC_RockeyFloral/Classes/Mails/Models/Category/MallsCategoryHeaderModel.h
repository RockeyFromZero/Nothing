//
//  MallsCategoryHeaderModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallsCategoryHeaderModel : NSObject

/** Section 展开 */
@property (nonatomic, assign) BOOL isShowChild;
/** 标题 */
@property (nonatomic, copy) NSString *title;

@end
