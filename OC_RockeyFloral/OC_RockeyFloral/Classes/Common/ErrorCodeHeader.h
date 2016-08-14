//
//  ErrorCodeHeader.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/13.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#ifndef ErrorCodeHeader_h
#define ErrorCodeHeader_h

typedef NS_ENUM(NSUInteger, ErrorCode) {
    ErrorCode_success,
    ErrorCode_fail,
    ErrorCode_NoMore,
    ErrorCode_Network
};

#define kErrorCodeSuccess @"以获取到数据"
#define kErrorCodeFail @"获取数据失败"
#define kErrorCodeNomore @"没有更多数据"
#define kErrorCodeNetwork @"网络故障,请检查网络设置"


#endif /* ErrorCodeHeader_h */
