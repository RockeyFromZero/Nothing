//
//  ShareVM.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"


#define kShareVMPlatform @"platform"
@interface ShareVM : NSObject

@property (nonatomic, strong) NSMutableArray *installedApi;

@end
