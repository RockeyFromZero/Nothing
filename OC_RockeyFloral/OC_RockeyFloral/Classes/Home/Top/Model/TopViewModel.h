//
//  TopViewModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/20.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artical.h"
#import "Author.h"

@interface TopViewModel : NSObject


/**  专题榜单 */
@property (nonatomic, strong) NSMutableArray *topAritcals;
/** 作者榜单 */
@property (nonatomic, strong) NSMutableArray *topAuthors;
/** Top 类型 */
@property (nonatomic, assign) TopType actionType;

/** 初始化 */
+ (instancetype)viewModelSuccess:(void (^)(ErrorCode ErrorCode, NSString *error))success 
                         failure:(void (^)(void))failure;

@end
