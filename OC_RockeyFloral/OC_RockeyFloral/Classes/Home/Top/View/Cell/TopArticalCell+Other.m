//
//  TopArticalCell+Other.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/20.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopArticalCell+Other.h"

@interface TopArticalOtherCell ()

@property (nonatomic, weak) UIImageView *logoView;

@end

@implementation TopArticalOtherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self bindModel];
    }
    return self;
}
- (void)setupUI {
    CGFloat margin = 10;
    [super setupUI];
    
    self.topSort.textColor = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.topLine.backgroundColor = [UIColor blackColor];
    self.underLine.backgroundColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.smallImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(margin);
        make.top.height.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    [self.logoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(margin);
        make.size.equalTo(CGSizeMake(97, 58));
        make.left.equalTo(self.smallImg.mas_right).offset((kScreenWidth-2*margin-kTopArticalOtherCellHeight-97)/2.0);
    }];

    [self.topSort makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.logoView);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoView);
        make.centerY.equalTo(self.contentView.mas_top).offset((kTopArticalOtherCellHeight-margin-58)/2+margin+58);
        make.width.equalTo(((kScreenWidth-2*margin-kTopArticalOtherCellHeight-97)*3/2.0));
    }];
    
    [self.topLine makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-margin/2);
        make.height.equalTo(1);
        make.width.centerX.equalTo(self.logoView);
    }];
    
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(margin/2);
        make.height.equalTo(1);
        make.width.centerX.equalTo(self.logoView);
    }];
}
- (void)bindModel {
    [super bindModel];
    
    [[RACObserve(self, artical) ignore:nil] subscribeNext:^(Artical *artical) {
        [self.smallImg sd_setImageWithURL:[NSURL URLWithString:artical.smallIcon] placeholderImage:[UIImage imageNamed:@"placehodler"] options:SDWebImageLowPriority completed:nil];
        self.titleLabel.text = artical.title;
    }];
}

#pragma mark - lazy load
- (UIImageView *)logoView {
    if (!_logoView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f_top"]];
        [self.contentView addSubview:imgView];
        _logoView = imgView;
    }
    return _logoView;
}

@end
