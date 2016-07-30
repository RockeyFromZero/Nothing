//
//  MallsCategoryHeader.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallsCategoryHeaderModel.h"

@class MallsCategoryHeader;
@protocol MallsCategoryHeaderDelegate <NSObject>

- (void)mallsCategoryHeader:(MallsCategoryHeader *)header didSelectAtSection:(NSInteger)section;

@end

@interface MallsCategoryHeader : UITableViewHeaderFooterView

@property (nonatomic, weak) id<MallsCategoryHeaderDelegate> delegate;

@property (nonatomic, strong) MallsCategoryHeaderModel *model;

@end
