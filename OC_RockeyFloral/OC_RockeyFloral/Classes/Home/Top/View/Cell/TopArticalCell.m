//
//  TopArticalCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/20.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopArticalCell.h"

@interface TopArticalCell ()

@end

@implementation TopArticalCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self bindModel];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(2, 0, 2, 0));
    }];
}
- (void)bindModel {
    [RACObserve(self, sort)  subscribeNext:^(id x) {
        self.topSort.text = [NSString stringWithFormat:@"TOP %@",x];
    }];
}

#pragma mark - lazy load
- (UIImageView *)smallImg {
    if (!_smallImg) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placehodler"]];
        [self.contentView addSubview:view];
        _smallImg = view;
    }
    return _smallImg;
}
- (UILabel *)topSort {
    if (!_topSort) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _topSort = label;
    }
    return _topSort;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UIView *)topLine {
    if (!_topLine) {
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        _topLine = view;
    }
    return _topLine;
}
- (UIView *)underLine {
    if (!_underLine) {
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        _underLine = view;
    }
    return _underLine;
}

@end
