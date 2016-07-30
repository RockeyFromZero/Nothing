//
//  NetworkTool.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTool : NSObject

+ (instancetype)sharedTool;
- (void)getAction:(NSString *)url paras:(id)paras success:(void (^)(id))success failure:(void (^)(id))failure;
- (void)postAction:(NSString *)url paras:(id)paras success:(void (^)(id))success failure:(void (^)(id))failure;

@end
