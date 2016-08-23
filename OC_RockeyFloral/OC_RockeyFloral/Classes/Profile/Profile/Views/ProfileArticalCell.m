//
//  ProfileArticalCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/9.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ProfileArticalCell.h"

@interface ProfileArticalCell ()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UIImageView *seperateLine;
@property (nonatomic, weak) UIButton *seeBtn;
@property (nonatomic, weak) UIButton *encourageBtn;

@end

@implementation ProfileArticalCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(Artical *artical) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:artical.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"] options:SDWebImageLowPriority completed:nil];
        self.nameLabel.text = artical.title;
        self.descLabel.text = artical.desc;
        [self.seeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)artical.read] forState:UIControlStateNormal];
        [self.encourageBtn setTitle:[NSString stringWithFormat:@"%ld",(long)artical.favo] forState:UIControlStateNormal];
    }];
}

- (void)setupUI {
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsZero);
    }];
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(140);
    }];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(10);
        make.left.equalTo(10);
        make.right.equalTo(-10);
    }];
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.nameLabel);
    }];
    [self.seperateLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(15);
        make.height.equalTo(1);
        make.left.equalTo(5);
        make.right.equalTo(-5);
    }];
    [self.encourageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperateLine.mas_bottom).offset(5);
        make.left.equalTo(10);
        make.width.equalTo(self.contentView).multipliedBy(0.4);
    }];
    [self.seeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).multipliedBy(0.8);
        make.top.width.equalTo(self.encourageBtn);
    }];
}

#pragma mark - lazy load
- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:11];
        label.text = @"花田小憩";
        [self.contentView addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}
- (UIImageView *)seperateLine {
    if (!_seperateLine) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self.contentView addSubview:view];
        _seperateLine = view;
    }
    return _seperateLine;
}

- (UIButton *)seeBtn {
    if (!_seeBtn) {
        _seeBtn = [[UIButton alloc] init];
        [_seeBtn setImage:[UIImage imageNamed:@"home_cell_see"] forState:UIControlStateNormal];
        [_seeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _seeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        _seeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _seeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _seeBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_seeBtn];
    }
    return _seeBtn;
}
- (UIButton *)encourageBtn {
    if (!_encourageBtn) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"home_cell_praise"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.userInteractionEnabled = false;
        [self.contentView addSubview:button];
        _encourageBtn = button;
    }
    return _encourageBtn;
}

@end
