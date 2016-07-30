//
//  UITextField+Extention.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "UITextField+Extention.h"

@implementation UITextField(Extention)

- (instancetype)initWithFrame:(CGRect)rect leftWidth:(CGFloat)width {
    if (self = [super init]) {
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    }
    return self;
}

@end
