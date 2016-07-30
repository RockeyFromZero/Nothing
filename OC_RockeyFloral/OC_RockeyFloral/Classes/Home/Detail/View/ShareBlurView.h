//
//  ShareBlurView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareVM.h"

#define kAnimateDuring 0.4
typedef NS_ENUM(NSInteger, ShareTag) {
    ShareTag_wechat = 1,
    ShareTag_wechatFriends,
    ShareTag_QQ,
    ShareTag_Sina
};

@interface ShareBlurView : UIVisualEffectView

/**  */

/** 主要是 显示几个 分享 */
@property (nonatomic, strong) ShareVM *shareVM;

- (instancetype)initWithEffect:(UIVisualEffect *)effect clickAtIndex:(void (^)(NSInteger))clickAtIndex;

- (void)startAnimate;
- (void)endAnimate;

@end
