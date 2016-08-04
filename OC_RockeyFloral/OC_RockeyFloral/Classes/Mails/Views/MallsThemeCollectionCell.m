//
//  MallsThemeCollectionCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/3.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsThemeCollectionCell.h"

@interface MallsThemeCollectionCell ()
/** 图像 */
@property (nonatomic, weak) UIImageView *imgView;
/** 类别 */
@property (nonatomic, weak) UILabel *typeLabel;
/** 名称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 价格 */
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation MallsThemeCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self bindModel];
    }
    return self;
}
- (void)createUI {
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(-5);
    }];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel);
        make.right.equalTo(-10);
        make.bottom.equalTo(self.priceLabel.mas_top).offset(-5);
    }];
    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel);
        make.bottom.equalTo(self.nameLabel.mas_top).offset(-5);
    }];

}
- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(Goods *model) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.fnAttachment] placeholderImage:[UIImage imageNamed:@"placehodler"] options:SDWebImageLowPriority];
        self.typeLabel.text = model.fnEnName;
        self.nameLabel.text = model.fnName;
        self.priceLabel.text = [NSString stringWithFormat:@"￥ %ld",(long)model.fnMarketPrice];
    }];
}

#pragma mark - lazy load
- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placehodler"]];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _typeLabel = label;
    }
    return _typeLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

@end
