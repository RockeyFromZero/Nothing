//
//  ProfileUserInfoCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/9.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ProfileUserInfoCell.h"

@interface ProfileUserInfoCell ()

@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UILabel *authorLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UIButton *shopBtn;
@property (nonatomic, weak) UIButton *remindBtn;

@property (nonatomic, weak) UILabel *pointLabel;
@property (nonatomic, weak) UIImageView *pointLine;
@property (nonatomic, weak) UILabel *pointNumLabel;
@property (nonatomic, weak) UILabel *experienceLabel;
@property (nonatomic, weak) UIImageView *experienceLine;
@property (nonatomic, weak) UIButton *levelBtn;
@property (nonatomic, weak) UIButton *experienceBtn;

@end

@implementation ProfileUserInfoCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, author) ignore:nil] subscribeNext:^(Author *author) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:author.headImg] placeholderImage:[UIImage imageNamed:@"pc_default_avatar"] options:SDWebImageLowPriority completed:nil];
        self.authorLabel.text = author.userName ? : @"佚名";
        self.descLabel.text = author.content ? : @"这家伙很懒, 什么也没留下...";
    }];
}

- (void)setupUI {
    
    [self.headImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(51, 51));
    }];
    [self.authorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImg).offset(5);
        make.left.equalTo(self.headImg.mas_right).offset(10);
        make.width.lessThanOrEqualTo(250);
    }];
    [self.remindBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.authorLabel);
        make.size.equalTo(CGSizeMake(35, 35));
    }];
    [self.shopBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remindBtn);
        make.right.equalTo(self.remindBtn.mas_left).offset(-5);
        make.size.equalTo(self.remindBtn);
    }];
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
        make.right.equalTo(self.shopBtn.mas_left).offset(15);
    }];
    [self.pointLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg);
        make.top.equalTo(self.headImg.mas_bottom).offset(20);
        make.height.equalTo(15);
    }];
    [self.pointLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointLabel.mas_right).offset(10);
        make.bottom.top.equalTo(self.pointLabel);
        make.width.equalTo(1);
    }];
    [self.pointNumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointLine.mas_right).offset(10);
        make.centerY.equalTo(self.pointLine);
    }];
    [self.experienceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointLabel);
        make.top.equalTo(self.pointLabel.mas_bottom).offset(10);
        make.height.equalTo(self.pointLabel);
    }];
    [self.experienceLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.experienceLabel);
        make.left.equalTo(self.experienceLabel.mas_right).offset(10);
        make.width.equalTo(1);
    }];
    [self.levelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.experienceLine.mas_right).offset(10);
        make.centerY.equalTo(self.experienceLine);
    }];
    [self.experienceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelBtn.mas_right).offset(10);
        make.top.equalTo(self.experienceLine);
        make.height.equalTo(self.pointLabel);
        make.width.equalTo(80);
    }];
}


#pragma mark - lazy load
-(UIImageView *)headImg {
    if (!_headImg) {
        UIImageView *imgView = [UIImageView new];
        imgView.aliCornerRadius = 51/2;
        imgView.image = [UIImage imageNamed:@"pc_default_avatar"];
        imgView.userInteractionEnabled = true;
        [self.contentView addSubview:imgView];
        _headImg = imgView;
    }
    return _headImg;
}
- (UILabel *)authorLabel {
    if (!_authorLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"经验值";
        [self.contentView addSubview:label];
        _authorLabel = label;
    }
    return _authorLabel;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"经验值";
        [self.contentView addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}
- (UIButton *)shopBtn {
    if (!_shopBtn) {
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"shoppingCar_35x35"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"shoppingCar_selec_35x35"] forState:UIControlStateSelected];
        [self.contentView addSubview:button];
        _shopBtn = button;
    }
    return _shopBtn;
}
- (UIButton *)remindBtn {
    if (!_remindBtn) {
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"setIcon_35x35"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"setIcon_selec_35x35"] forState:UIControlStateSelected];
        [self.contentView addSubview:button];
        _remindBtn = button;
    }
    return _remindBtn;
}

- (UILabel *)pointLabel {
    if (!_pointLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"经验值";
        [self.contentView addSubview:label];
        _pointLabel = label;
    }
    return _pointLabel;
}
- (UIImageView *)pointLine {
    if (!_pointLine) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f_loginfo_line_0x61"]];
        [self.contentView addSubview:view];
        _pointLine = view;
    }
    return _pointLine;
}
- (UILabel *)pointNumLabel {
    if (!_pointNumLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"0";
        [self.contentView addSubview:label];
        _pointNumLabel = label;
    }
    return _pointNumLabel;
}
- (UILabel *)experienceLabel {
    if (!_experienceLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"经验值";
        [self.contentView addSubview:label];
        _experienceLabel = label;
    }
    return _experienceLabel;
}
- (UIImageView *)experienceLine {
    if (!_experienceLine) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f_loginfo_line_0x61"]];
        [self.contentView addSubview:view];
        _experienceLine = view;
    }
    return _experienceLine;
}
- (UIButton *)levelBtn {
    if (!_levelBtn) {
        UIButton *button = [UIButton new];
        [button setTitle:@"lv.1" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:8];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"pc_level_bg_33x10"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _levelBtn = button;
    }
    return _levelBtn;
}
- (UIButton *)experienceBtn {
    if (!_experienceBtn) {
        UIButton *button = [UIButton new];
        [button setTitle:@"0" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"empirical_57x9"] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.contentView addSubview:button];
        _experienceBtn = button;
    }
    return _experienceBtn;
}


@end
