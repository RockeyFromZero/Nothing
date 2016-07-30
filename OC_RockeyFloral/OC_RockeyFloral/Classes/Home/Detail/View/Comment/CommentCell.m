//
//  CommentCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()

/** 头像 */
@property (nonatomic, weak) UIImageView *headImg;
/** 用户名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *dateDescLabel;
/** 评论 内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 回复 */
@property (nonatomic, weak) UIButton *replyButton;
/** 更多 */
@property (nonatomic, weak) UIButton *moreButton;
/** 分割线 */
@property (nonatomic, weak) UIImageView *underLine;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(CommentModel *model) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.writer.headImg] placeholderImage:[UIImage imageNamed:@"head_default_avatar"] options:SDWebImageLowPriority];
        self.nameLabel.text = model.anonymous ? @"匿名" : model.writer.userName;
        self.dateDescLabel.text = model.createDateDesc;
        
        if (model.toUser.ID.length > 0) {
            NSString *toName = model.toUser.userName.length>0 ? [NSString stringWithFormat:@"@[%@]",model.toUser.userName] : @"@[匿名用户]";
            NSString *content = [NSString stringWithFormat:@"%@%@",toName,model.content];
            NSRange range = [content rangeOfString:toName];
            NSMutableAttributedString *arr = [[NSMutableAttributedString alloc] initWithString:content];
            [arr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:203 green:47 blue:34]} range:range];
            self.contentLabel.attributedText = arr;
        } else {
            self.contentLabel.text = model.content;
        }
        
    }];
}

- (void)setupUI {

    [self.headImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kDefaultMargin15);
        make.top.equalTo(kDefaultMargin10);
        make.size.equalTo(CGSizeMake(kDefaultHeadHeight, kDefaultHeadHeight));
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(kDefaultMargin10);
        make.top.equalTo(self.headImg).offset(kDefaultMargin10);
    }];
    
    [self.dateDescLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(-kDefaultMargin15);
    }];
    
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(-kDefaultMargin20);
        make.top.equalTo(self.headImg.mas_bottom);
    }];
    
    [self.moreButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateDescLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kDefaultMargin10);
        make.width.equalTo(40);
    }];
    
    [self.replyButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moreButton);
        make.right.equalTo(self.moreButton.mas_left);
    }];
    
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg);
        make.right.bottom.equalTo(self.contentView);
    }];

}

#pragma mark - lazy Load
- (UIImageView *)headImg {
    if (!_headImg) {
        UIImageView *imgView = [UIImageView new];
        imgView.aliCornerRadius = kDefaultHeadHeight/2.0;
        [self.contentView addSubview:imgView];
        _headImg = imgView;
    }
    return _headImg;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}
- (UILabel *)dateDescLabel {
    if (!_dateDescLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _dateDescLabel = label;
    }
    return _dateDescLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}
- (UIButton *)replyButton {
    if (!_replyButton) {
        UIButton *button = [UIButton new];
        [button setTitle:@"回复" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:button];
        _replyButton = button;
    }
    return _replyButton;
}
- (UIButton *)moreButton {
    if (!_moreButton) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[[UIImage imageNamed:@"p_more_19x15"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setImage:[[UIImage imageNamed:@"p_more_19x15"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [self.contentView addSubview:button];
        _moreButton = button;
    }
    return _moreButton;
}
- (UIImageView *)underLine {
    if (!_underLine) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self.contentView addSubview:imgView];
        _underLine = imgView;
    }
    return _underLine;
}

@end
