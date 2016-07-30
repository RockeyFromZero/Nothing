//
//  Category.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/29.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCategory : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger order;

@end
