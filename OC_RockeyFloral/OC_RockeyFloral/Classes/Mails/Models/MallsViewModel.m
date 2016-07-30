//
//  MallsViewModel.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsViewModel.h"

//http://ec.htxq.net/rest/htxq/index/"+id

@implementation MallsViewModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)getDataList {
    [[NetworkTool sharedTool] getAction:@"http://ec.htxq.net/rest/htxq/index/jingList/1" paras:nil success:^(id success) {
        
    } failure:^(id failure) {
        
    }];
}



@end
