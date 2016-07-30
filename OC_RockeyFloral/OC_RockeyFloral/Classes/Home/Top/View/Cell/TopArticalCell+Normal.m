//
//  TopArticalCell+Normal.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/20.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopArticalCell+Normal.h"

@implementation TopArticalNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self bindModel];
    }
    return self;
}
- (void)setupUI {
    [super setupUI];
    CGFloat margin = 10;
    
    [self.smallImg makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, margin, 0, margin));
    }];
    
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    self.underLine.backgroundColor = [UIColor whiteColor];
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
        make.height.equalTo(1);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    self.topLine.backgroundColor = [UIColor whiteColor];
    [self.topLine makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-margin);
        make.height.equalTo(1);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_height);
    }];
    
    self.topSort.textColor = [UIColor whiteColor];
    [self.topSort makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topLine.mas_top).offset(-margin);
        make.centerX.equalTo(self.contentView);
    }];
    
    self.logoLabel.textColor = [UIColor whiteColor];
    [self.logoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.underLine.mas_bottom).offset(margin);
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
- (UILabel *)logoLabel {
    if (!_logoLabel) {
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        label.text = @"Flower && Flower";
        _logoLabel = label;
    }
    return _logoLabel;
}

@end
