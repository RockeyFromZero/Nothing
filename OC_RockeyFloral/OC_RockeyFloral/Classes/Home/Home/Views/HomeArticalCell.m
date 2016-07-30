//
//  HomeArticalCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/30.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "HomeArticalCell.h"
#import "HomeCellBottomView.h"

@interface HomeArticalCell ()

/** 顶部 图像 */
@property (nonatomic, weak) UIImageView *smallIcon;
/** 头像 */
@property (nonatomic, weak) UIImageView *headIcon;
/** 认证头像 */
@property (nonatomic, weak) UIImageView *authIcon;
/** 作者 */
@property (nonatomic, weak) UILabel *authorLabel;
/** 称号 */
@property (nonatomic, weak) UILabel *identifyLabel;
/** 分类 */
@property (nonatomic, weak) UILabel *categoryLabel;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 摘要 */
@property (nonatomic, weak) UILabel *descLabel;
/** 分割线 */
@property (nonatomic, weak) UIImageView *underLine;
/** 底部栏目 */
@property (nonatomic, weak) HomeCellBottomView *bottomView;

@end


@implementation HomeArticalCell
static CGFloat kHeadIconWH = 51;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self bingModel];
    }
    return self;
}

- (void)bingModel {
    [[RACObserve(self, artical) ignore:(nil)] subscribeNext:^(Artical *artical) {
        [self.smallIcon sd_setImageWithURL:[NSURL URLWithString:artical.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"] options:SDWebImageLowPriority];
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:artical.author.headImg] placeholderImage:[UIImage imageNamed:@"head_default_avatar"] options:SDWebImageLowPriority];
        self.authIcon.image = artical.author.authImage;
        self.identifyLabel.text = artical.author.identity;
        self.authorLabel.text  = artical.author.userName;
        self.categoryLabel.text = [NSString stringWithFormat:@"[%@]",artical.category.name];
        self.titleLabel.text = artical.title;
        self.descLabel.text = artical.desc;
        self.bottomView.artical = artical;
    }];
}

- (void)setupUI {

    self.backgroundColor = [UIColor colorWithHexString:@"cecece"];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(6, 6, 0, 6));
    }];
    
    [self.smallIcon makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(160);
    }];
    
    [self.headIcon makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kHeadIconWH, kHeadIconWH));
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.smallIcon.mas_bottom).offset(-10);
    }];
    
    [self.authIcon makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(14, 14));
        make.bottom.right.equalTo(self.headIcon);
    }];
    
    [self.authorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headIcon.mas_left).offset(-10);
        make.top.equalTo(self.smallIcon.mas_bottom).offset(8);
    }];
    
    [self.identifyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.authorLabel);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(4);
    }];
    
    [self.categoryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.identifyLabel.mas_bottom);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.categoryLabel);
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(10);
        make.width.lessThanOrEqualTo(self.contentView).offset(-20);
    }];
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.width.lessThanOrEqualTo(self.contentView).offset(-40);
        make.height.equalTo(30);
    }];
    
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).offset(5);
        make.left.equalTo(self.descLabel).offset(5);
        make.right.equalTo(self.headIcon);
    }];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.underLine.mas_bottom).offset(3);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(30);
    }];
    
}

#pragma mark - Lazy load
- (UIImageView *)smallIcon {
    if (!_smallIcon) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        _smallIcon = imgView;
    }
    return _smallIcon;
}
- (UIImageView *)headIcon {
    if (!_headIcon) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.aliCornerRadius = kHeadIconWH/2;
        [self.contentView addSubview:imgView];
        _headIcon = imgView;
    }
    return _headIcon;
}
- (UIImageView *)authIcon {
    if (!_authIcon) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        _authIcon = imgView;
    }
    return _authIcon;
}
- (UILabel *)authorLabel {
    if (!_authorLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        [self.contentView addSubview:label];
        _authorLabel = label;
    }
    return _authorLabel;
}
- (UILabel *)identifyLabel {
    if (!_identifyLabel) {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        [self.contentView addSubview:label];
        _identifyLabel = label;
    }
    return _identifyLabel;
}
- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        [self.contentView addSubview:label];
        _categoryLabel = label;
    }
    return _categoryLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:12];
        [self.contentView addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}
- (UIImageView *)underLine {
    if (!_underLine) {
        UIImageView *label = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self.contentView addSubview:label];
        _underLine = label;
    }
    return _underLine;
}

- (HomeCellBottomView *)bottomView {
    if (!_bottomView) {
        HomeCellBottomView *bottomView = [[HomeCellBottomView alloc] init];
        [self.contentView addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}

@end
