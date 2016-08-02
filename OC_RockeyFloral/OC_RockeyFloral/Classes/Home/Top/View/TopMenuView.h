//
//  TopMenuView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopMenuView : UIView

+ (instancetype)topMenu:(void (^)(TopType))topType;
- (instancetype)initWithBlock:(void (^)(TopType))topType;

@property (nonatomic, copy) NSArray *titles;

@end
