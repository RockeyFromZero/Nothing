//
//  TopAuthorCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopAuthorCell.h"

@interface TopAuthorCell ()

/** 头像 */
@property (nonatomic, weak) UIImageView *headImg;
/** 认证 等级 */
@property (nonatomic, weak) UIImageView *authImg;
/** auth Name */
@property (nonatomic, weak) UILabel *authLabel;
/** top level 排名 */
@property (nonatomic, weak) UILabel *sortLabel;

@end

CGFloat kAuthImgWH = 15;
CGFloat kHeadImgWH = 51;
@implementation TopAuthorCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self bindModel];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.headImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(kHeadImgWH, kHeadImgWH));
    }];
    [self.authImg makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kAuthImgWH, kAuthImgWH));
        make.right.equalTo(self.headImg);
        make.bottom.equalTo(self.headImg);
    }];
    
    [self.authLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.headImg.mas_right).offset(8);
    }];
    
    [self.sortLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-15);
    }];
}
- (void)bindModel {
    [RACObserve(self, sort)  subscribeNext:^(id x) {
        self.sortLabel.text = [NSString stringWithFormat:@"TOP %@",x];
    }];
    [[RACObserve(self, author) ignore:nil] subscribeNext:^(Author *author) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:author.headImg] placeholderImage:[UIImage imageNamed:@"pc_default_avatar"] options:SDWebImageLowPriority];
        self.authImg.image = author.authImage;
        self.authLabel.text  = author.userName;
    }];
}

#pragma mark - lazy load
- (UIImageView *)headImg {
    if (!_headImg) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_default_avatar"]];
        imgView.aliCornerRadius = kHeadImgWH/2.0;
        [self.contentView addSubview:imgView];
        _headImg = imgView;
    }
    return _headImg;
}
- (UIImageView *)authImg {
    if (!_authImg) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personAuth"]];
        imgView.aliCornerRadius = kAuthImgWH/2.0;
        [self.contentView addSubview:imgView];
        _authImg = imgView;
    }
    return _authImg;
}
- (UILabel *)authLabel {
    if (!_authLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        [self.contentView addSubview:label];
        _authLabel = label;
    }
    return _authLabel;
}
- (UILabel *)sortLabel {
    if (!_sortLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:20];
        [self.contentView addSubview:label];
        _sortLabel = label;
    }
    return _sortLabel;
}

@end
