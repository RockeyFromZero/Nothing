//
//  DetailHeaderView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "DetailHeaderView.h"

@interface DetailHeaderView ()

/** 头像 */
@property (nonatomic, weak) UIImageView *headImg;
/** 认证 */
@property (nonatomic, weak) UIImageView *authImg;
/** 用户名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 头衔 */
@property (nonatomic, weak) UILabel *authLabel;
/** 订阅量 */
@property (nonatomic, weak) UILabel *subNumber;
/** 订阅按钮 */
@property (nonatomic, weak) UIButton *subscribe;


@end

@implementation DetailHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self bingModel];
    }
    return self;
}

- (void)bingModel {
    [[RACObserve(self, artical) ignore:nil] subscribeNext:^(Artical *artical) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:artical.author.headImg] placeholderImage:[UIImage imageNamed:@"head_default_avatar"] options:SDWebImageLowPriority];
        self.authImg.image = artical.author.authImage;
        self.nameLabel.text = artical.author.userName;
        self.authLabel.text = [NSString stringWithFormat:@"[%@]",artical.author.auth];
        self.subNumber.text = [NSString stringWithFormat:@"已经有%ld人订阅",artical.author.subscibeNum];
    }];
}

- (void)setupUI {
   [self.headImg makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.contentView);
       make.left.equalTo(10);
       make.size.equalTo(CGSizeMake(31, 31));
   }];
    [self.authImg makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.headImg);
        make.size.equalTo(CGSizeMake(8, 8));
    }];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(5);
        make.centerY.equalTo(self.contentView);
    }];
    [self.authLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.subscribe makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(50, 25));
    }];;
    [self.subNumber makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.subscribe.mas_left).offset(-5);
        make.centerY.equalTo(self.contentView);
    }];
}



#pragma mark - Lazy Load
- (UIImageView *)headImg {
    if (!_headImg) {
        UIImageView *imgView = [UIImageView new];
        imgView.aliCornerRadius = 51.0/2;
        [self.contentView addSubview:imgView];
        _headImg = imgView;
    }
    return _headImg;
}
- (UIImageView *)authImg {
    if (!_authImg) {
        UIImageView *imgView = [UIImageView new];
        imgView.aliCornerRadius = 4;
        [self.contentView addSubview:imgView];
        _authImg = imgView;
    }
    return _authImg;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        [self labelStyle:label];
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
- (UILabel *)authLabel {
    if (!_authLabel) {
        UILabel *label = [UILabel new];
        [self labelStyle:label];
        [self.contentView addSubview:label];
        _authLabel = label;
    }
    return _authLabel;
}
- (UILabel *)subNumber {
    if (!_subNumber) {
        UILabel *label = [UILabel new];
        [self labelStyle:label];
        [self.contentView addSubview:label];
        _subNumber = label;
    }
    return _subNumber;
}
- (UIButton *)subscribe {
    if (!_subscribe) {
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor colorWithRed:255 green:211 blue:117];
        [button setTitle:@"订阅" forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:.8] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        button.clipsToBounds = YES;
        [self.contentView addSubview:button];
        _subscribe = button;
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(detailHeaderAction)]) {
                [_delegate detailHeaderAction];
            }
        }];
    }
    return _subscribe;
}
- (void)labelStyle:(UILabel *)label {
    label.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
}

@end
