//
//  HomeViewModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/5.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artical.h"

@interface HomeViewModel : NSObject

+ (instancetype)viewModel:(void (^)(id))success failure:(void (^)(id))failure;
- (void)getNext;
- (void)getFirst;

@end
