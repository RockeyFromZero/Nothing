//
//  MallsViewModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallsGoods.h"

@interface MallsViewModel : NSObject

@property (nonatomic, assign)  MallType mallType;

+ (instancetype)viewModel:(void (^)(ErrorCode ErrorCode, id))success 
                         failure:(void (^)(void))failure;

- (void)getFirst;
- (void)getNext;

@end
