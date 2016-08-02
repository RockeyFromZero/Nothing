//
//  ADSViewModel.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADS.h"

@interface ADSViewModel : NSObject

+ (instancetype)ADSViewModel:(void (^)(ErrorCode ErrorCode, id))response; 

- (void)refresh;

@end
