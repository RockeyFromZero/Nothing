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
        [self createUI];
        [self bindModel];
    }
    return self;
}
- (void)createUI {
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.top.equalTo(12);
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descLabel);
        make.top.equalTo(self.descLabel.mas_bottom).offset(5);
    }];
    [self.button makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(-20);
    }];
}
- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(MallsGoods *model) {
        self.descLabel.text = model.fnDesc;
        self.titleLabel.text = model.fnName;
    }];
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
