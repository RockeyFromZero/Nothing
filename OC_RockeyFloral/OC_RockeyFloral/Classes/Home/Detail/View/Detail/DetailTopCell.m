//
//  DetailTopCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "DetailTopCell.h"

@interface DetailTopCell ()

/** 顶部图片 */
@property (nonatomic, weak) UIImageView *topImage;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 分类 */
@property (nonatomic, weak) UILabel *categoryLabel;
/** 分割线 */
@property (nonatomic, weak) UIImageView *underLine;

@end

@implementation DetailTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, artical) ignore:nil] subscribeNext:^(Artical *artical) {
        [self.topImage sd_setImageWithURL:[NSURL URLWithString:artical.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"] options:0];
        self.titleLabel.text = artical.title;
        self.categoryLabel.text = [NSString stringWithFormat:@"# %@ #",artical.category.name];
        
    }];
}
- (void)setupUI {
    [self.topImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(160);
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImage.mas_bottom).offset(20);
        make.centerX.equalTo(self.contentView);
    }];
    [self.categoryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    
    CGFloat lineWidth = [@"#家居庭院#" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CODE LIGHT" size:13]} context:nil].size.width;
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(lineWidth);
    }];
}

#pragma lazy load
- (UIImageView *)topImage {
    if (!_topImage) {
        UIImageView *imageView = [UIImageView new];
        [self.contentView addSubview:imageView];
        _topImage  = imageView;
    }
    return _topImage;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
        [self.contentView addSubview:label];
        _categoryLabel = label;
    }
    return _categoryLabel;
}
- (UIImageView *)underLine {
    if (!_underLine) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self.contentView addSubview:imageView];
        _underLine  = imageView;
    }
    return _underLine;
}

@end
