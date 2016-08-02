//
//  MallsNormalCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsNormalCell.h"

@interface MallsNormalCell ()

@property (nonatomic, weak) UIImageView *topImgView;
/** 推荐 / 最热 */
@property (nonatomic, weak) UIButton *typeBtn;
/** 分类 */
@property (nonatomic, weak) UILabel *categoryLabel;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 价格 */
@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation MallsNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(Goods *model) {
        
        [self.topImgView sd_setImageWithURL:[NSURL URLWithString:model.fnAttachment] placeholderImage:[UIImage imageNamed:@"placehodler"] options:SDWebImageLowPriority];
        self.categoryLabel.text = model.fnEnName;
        self.titleLabel.text = model.fnName;
        self.priceLabel.text = [NSString stringWithFormat:@"%ld",(long)model.fnMarketPrice];
        [self.typeBtn setBackgroundImage:model.fnjianIcon forState:UIControlStateNormal];
        [self.typeBtn setTitle:model.fnjianTitle forState:UIControlStateNormal];
    }];
}

- (void)createUI {
    self.backgroundColor = [UIColor gray:241];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [self.topImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(190);
    }];
    [self.typeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.topImgView.mas_bottom).offset(20);
        make.size.equalTo(CGSizeMake(28, 25.5));
    }];
    [self.categoryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeBtn.mas_right).offset(15);
        make.top.equalTo(self.topImgView.mas_bottom).offset(15);
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryLabel);
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(5);
    }];
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
}


#pragma mark - lazy load
- (UIImageView *)topImgView {
    if (!_topImgView) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placehodler"]];
        [self.contentView addSubview:view];
        _topImgView = view;
    }
    return _topImgView;
}
- (UIButton *)typeBtn {
    if (!_typeBtn) {
        UIButton *button = [UIButton new];
        [button setBackgroundImage:[UIImage imageNamed:@"f_jian_56x51"] forState:UIControlStateNormal];
        [button setTitle:@"推荐" forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:button];
        _typeBtn = button;
    }
    return _typeBtn;
}
- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        [self.contentView addSubview:label];
        _categoryLabel = label;
    }
    return _categoryLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:15];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor brownColor];
        [self.contentView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}

@end
