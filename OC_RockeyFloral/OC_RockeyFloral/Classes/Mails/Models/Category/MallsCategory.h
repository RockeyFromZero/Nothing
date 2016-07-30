//
//  MallsCategory.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallsCategory : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *fnId;
@property (nonatomic, copy) NSString *fnPid;
@property (nonatomic, copy) NSString *fnName;
@property (nonatomic, copy) NSString *fnDesc;
@property (nonatomic, copy) NSArray *childrenList;

@end
