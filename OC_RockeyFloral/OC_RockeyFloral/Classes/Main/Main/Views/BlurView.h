//
//  BlurView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/28.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

typedef NS_ENUM(NSInteger, BlurViewType) {
    /** 主页 */
    BlurViewType_home,
    /** 商城 */
    BlurViewType_malls
};

@interface BlurView : UIVisualEffectView

@property (nonatomic, copy) NSArray *categories;

@property (nonatomic, assign) BlurViewType type;

- (instancetype)initWithSelectCategory:(void(^)(RCategory *))selectCategoryBlock;

@end
