//
//  MallsThemeCellHeader.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/2.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsThemeCellHeader.h"

@interface MallsThemeCellHeader ()
/** 描述 */
@property (nonatomic, weak) UILabel *descLabel;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *button;

@end

@implementation MallsThemeCellHeader
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)createUI {
    
}


#pragma mark - lazy load
- (UILabel *)descLabel {
    if (!_descLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UIButton *)button {
    if (!_button) {
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"goto"] forState:UIControlStateNormal];
        [self addSubview:button];
        _button = button;
    }
    return _button;
}

@end
